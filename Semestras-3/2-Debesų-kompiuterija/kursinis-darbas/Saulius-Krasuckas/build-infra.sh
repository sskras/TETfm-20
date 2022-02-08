#!/usr/bin/env bash
#
# 2022-01-31 saukrs: Pradedu kursinį darbą.
#
# Kopijuosiu skripto dalis iš praėjusio semestro IiSA laboratorinių darbų:
# https://github.com/VGTU-ELF/TETfm-20/blob/main/Semestras-2/1-Informacijos-ir-sistem%C5%B3-apsauga/laboratoriniai-darbai/Saulius-Krasuckas/0LD-infra.sh

BASE_DIR=$(builtin cd $(dirname $0); pwd)                   # Darbinė direktorija ten, kur skriptas
LOG_FILE=${BASE_DIR}/$(basename ${0%.sh}).log               # Log failo vardas pagal skripto vardą (tik pakeičiu plėtinį)

IF_HOST_UPLINK="Intel(R) Dual Band Wireless-AC 8260"        # Interfeisas neribotam ryšiui
IF_HOSTONLY="VirtualBox Host-Only Ethernet Adapter"         # Interfeisas, kuriuo vyks VMų OAM (Operation, Administration, Maintenance)
NAT_NET_ADDR="10.1.1.0/24"                                  # Potinklis, kuriame veiks aplikacija
NAT_NET_NAME="NAT-network-APP"                              # Potinklio vardas

UART_SCR=${LOG_FILE%.log}-serial.script                     # Script failas VMų Serial/UART konsolei
UART_LOG=${LOG_FILE%.log}-serial.log                        # Log failas VMų Serial/UART konsolei
UART_TCP_PORT="23001"                                       # Host TCP prievadas, skirtas ryšiui su konsole
UART_I_O_PORT="0x3f8"                                       # VM Serial/UART I/O prievadas (aparatinis)
UART_IRQ="4"                                                # VM Serial/UART IRQ numeris

VM_CPUS=2                                                   # VM CPU skaičius
VM_RAM=1024                                                 # VM RAM apimtis

VM0="VGTU-2022-DeKo-saukrs-CPVM0"                           # Bendros VM vardas
VM0_01_CLEAN="${VM0}-01-CLEAN"
VM0_02_SSH_OK="${VM0}-02-SSH-OK"

VDI_URL="https://sourceforge.net/projects/osboxes/files/v/vb/55-U-u/20.04/20.04.3/Desktop/64bit.7z/download?use_mirror=netix"
VDI_ZIP="Ubuntu-20.04.3-Desktop-64bit.7z"
VDI_FILE="64bit/Ubuntu 20.04.3 (64bit).vdi"                 # Pagrindinio (Golden) VDI failo vardas


set -e
set -o pipefail
shopt -s lastpipe

# From: https://stackoverflow.com/a/69151087/1025073
#   keep track of the last executed command
trap 'LAST_COMMAND=$CURRENT_COMMAND; CURRENT_COMMAND=$BASH_COMMAND' DEBUG
#   on error: print the failed command
trap 'PIPES="${PIPESTATUS[@]}"; ERROR_CODE=$?; FAILED_COMMAND=$LAST_COMMAND; tput setaf 1; echo "ERROR: command \"$FAILED_COMMAND\" failed with exit code $ERROR_CODE"; tput sgr0; echo "PIPES: ${PIPES}"' ERR INT TERM


# TODO: Jei vietoje `tee` panaudotume GNU `script`, išliktų terminalinės spalvos.
exec > >(tee -i "${LOG_FILE}") 2>&1                         # Dubliuoju išvestį į logą


out () {
    echo -e "\n$*\n"
}

VBox_setup_serial_console () {

    export LINES COLUMNS
    stty size | read LINES COLUMNS

    echo "VM lange Spauskite kombinaciją <Host-P>, tuomet <Esc>"
    echo "Kartokite <Esc> paspaudimus be perstojo."
    echo "Kai pasirodys GRUB meniu, spauskite <e>"
    echo "Eikite žemyn iki eilutės:"
    echo
    echo "        linux        /boot/vmlinuz-..."
    echo
    echo "Spauskite <End> ir gale prirašykite:"
    echo
    echo "... console=ttyS0,115200n8"
    echo
    echo "Taip pat ištrinkite tokius parametrus:"
    echo
    echo "... quiet ..."
    echo "... splash ..."
    echo
    echo "VM paspauskite <Ctrl-X>, startuos OS."
    echo
    echo "Sugrįžkite atgal į terminalą."
    echo "Patekote į VM Serial konsolę."
    echo
    echo "Prisijunkite prie OS (osboxes:osboxes.org),"
    echo "paleiskite komandą:"
    echo
    echo " $ stty rows $LINES columns $COLUMNS ; sudo apt update ; sudo apt install -y openssh-server"
    echo
    echo "... ir palaukite įvykdymo"
    echo "Sėkmės atveju atsijunkite su Serial konsolės su ^] + ^D"

    # Išvalau būsimą Serial logą:
    > ${UART_SCR}

    # Jungiamės prie virtualios Serial konsolės per TCP:
    script -q -c "echo; telnet 127.0.0.1 ${UART_TCP_PORT}" ${UART_SCR}

    # Išsaugome Serial konsolės logą Plain-text formatu:
    cat ${UART_SCR} | ansifilter | sed '1d;$d' > ${UART_LOG}
}


function VBox_get_OAM_MAC () {
    VM="$1"
    VBoxManage showvminfo "$VM" \
        | awk 'BEGIN {FS="[ ,]+"} /NIC [23]:/ && !/disabled$/ {print tolower($4)}'
}


function VBox_get_OAM_IP () {
    VM="$1"
    VBox_get_OAM_MAC ${VM} | read MAC
    cat /C/Users/saukrs/.VirtualBox/*.leases \
        | awk 'BEGIN {FS="\""} /'$MAC'/ {GO=1; MAC_AT=NR} GO && NR == MAC_AT+1 {print $2}'
}

# Pradžia:


function MSYS2_fixes () {

   # Jei Windows, papildau PATH į VBoxManage.exe dirą.
   # Taip pat primapinu Windows jūzerio VirtualBox subdirą prie MSYS2 jūzerio home-diros:

    if [[ $(uname -o) == "Msys" ]]; then

        if [ ! -x "(shell command -v VBoxManage)" ]; then
            PATH=$PATH:/C/Program\ Files/Oracle/VirtualBox
        fi

        if [ ! -d ~/.VirtualBox ]; then
            env MSYS=winsymlinks:nativestrict sudo ln -s /C/Users/saukrs/.VirtualBox ~/
        fi

	# Panaudosiu Cygwin ping portą vietoj nebesveikai nesiintegruojančio NT porto:
	. ~/bin/ping-NT-fixes.sh
    fi
}


function build_gold () {

    echo "$(basename $0): Pradinio VM atvaizdžio konfigūravimas"

   #TODO: įprastinių GUI įspėjimų (Baloon) išjungimas, http://www.edugeek.net/forums/thin-client-virtual-machines/192994-virtualbox-3.html#33
   #
   #      Pvz.: šitai ~/.VirtualBox/VirtualBox.xml eilutei:
   #
   # +      <ExtraDataItem name="GUI/SuppressMessages" value="remindAboutAutoCapture"/>
   #
   #      "C:\Program Files\Oracle\VirtualBox\vboxmanage.exe" setextradata global GUI/SuppressMessages remindAboutAutoCapture,remindAboutMouseIntegrationOn,showRuntimeError.warning.HostAudioNotResponding,remindAboutGoingSeamless,remindAboutInputCapture,remindAboutGoingFullscreen,remindAboutMouseIntegrationOff,confirmGoingSeamless,confirmInputCapture,remindAboutPausedVMInput,confirmVMReset,confirmGoingFullscreen,remindAboutWrongColorDepth
                                                               cd ${BASE_DIR}/VMs
   #out "- Host OS atvaizdžio parsiuntimas:"                 ; curl -LC - ${VDI_URL} -o ${VDI_ZIP} || { echo "Parsisiųsti \"${VDI_ZIP}\" nepavyko, pabaiga"; exit; }
    out "- Host OS atvaizdžio išspaudimas:"                  ; bsdtar -tvf ${VDI_ZIP} \
                                                                       | awk '/vdi$/ {$1=$2=$3=$4=$5=$6=$7=$8=""; print}' \
                                                                       | read VDI_FILE
                                                               bsdtar -xvkf ${VDI_ZIP} #\
                                                                      #| grep --color -e $ -e "${VDI_FILE}"
    out "- Host OS atvaizdžio informacija:"                  ; VBoxManage showmediuminfo disk "${VDI_FILE}" \
                                                                       | awk '/^UUID/ {print $2}' \
                                                                       | read VDI_UUID
                                                               VBoxManage showmediuminfo disk "${VDI_FILE}" #\
                                                                      #| grep --color -e $ -e "${VDI_UUID}"
                                                               VBoxManage modifyhd ${VDI_UUID} --type normal
                                                               cd - > /dev/null

    out "- Pradinės VM:"                                     ; VBoxManage list vms
                                                               VBoxManage showvminfo ${VM0} > /dev/null 2>&1 && \
                                                               {
                                                                       echo
                                                                       echo "VM \"${VM0}\" jau egzistuoja, darbas stabdomas"
                                                                       exit
                                                               }
    out "- Nauja VM:"                                        ; VBoxManage createvm --name ${VM0} --ostype Ubuntu_64 --basefolder ${BASE_DIR}/VMs --register
    out "- Dabartinės VM:"                                   ; VBoxManage list vms

    out "- Naujos VM pirminė konfigūracija:"                 ; VBoxManage showvminfo ${VM0} | grep -e CPUs -e Memory
    out "- Naujos VM resursų plėtimas:"                      ; VBoxManage modifyvm ${VM0} --cpus ${VM_CPUS} --memory ${VM_RAM}
    out "- Naujos VM išplėsti resursai:"                     ; VBoxManage showvminfo ${VM0} | grep -e CPUs -e Memory

    out "- Naujai VM prijungiu diskų valdiklį:"              ; VBoxManage storagectl ${VM0} --name "SATA valdiklis" --add sata --portcount 3 --bootable on
    out "- Naujos VM diskinė konfigūracija:"                 ; VBoxManage showvminfo ${VM0} | grep -i storage
    out "- Naujai VM prijungiu disko ataizdį:"               ; VBoxManage storageattach ${VM0} --storagectl "SATA valdiklis" --port 0 --device 0 --type hdd --medium ${VDI_UUID}
                                                               VBoxManage showmediuminfo disk ${VDI_UUID}
    out "- Naujos VM diskų valdiklio konfigūracija:"         ; VBoxManage showvminfo --details ${VM0} | grep "^SATA valdiklis"

    out "- Naujos VM tinklo konfigūracija:"                  ; VBoxManage showvminfo ${VM0} | awk '/^NIC/ && !/^NIC .* disabled/'
    out "- Naujos VM OAM tinklas:"                           ; VBoxManage modifyvm ${VM0} --nic2 hostonly --hostonlyadapter2 "${IF_HOSTONLY}"
    out "- Naujos VM papildyta tinklo konfigūracija:"        ; VBoxManage showvminfo ${VM0} | awk '/^NIC/ && !/^NIC .* disabled/'

    out "- Naujos VM Serial konsolė:"                        ; VBoxManage modifyvm ${VM0} --uart1 ${UART_I_O_PORT} ${UART_IRQ} --uartmode1 tcpserver ${UART_TCP_PORT}
                                                               VBoxManage showvminfo ${VM0} | grep "UART"
    out "- Naujos VM startas:"                               ; VBoxManage startvm ${VM0}
    out "- Naujos VM pristabdymas:"                          ; VBoxManage controlvm ${VM0} pause
    out "- Naujos VM švarus pradinis snapšotas:"             ; VBoxManage snapshot ${VM0} take ${VM0_01_CLEAN} --live
    out "- Naujos VM tvarkymas konsolėje:"                   ; VBox_setup_serial_console ${VM0}
    out "- Naujos VM snapšotas su įjungtu SSH:"              ; VBoxManage snapshot ${VM0} take ${VM0_02_SSH_OK} --live
    out "- Naujos VM OAM IP:"                                ; VBox_get_OAM_MAC ${VM0} | read OAM_IP; echo ${OAM_IP}

    out "- Naujos VM tvarkymas per SSH:"                     ; ${BASE_DIR}/setup-osboxes-ubuntu-20.04.sh ${OAM_IP}
                                                               [ ! $? = "0" ] && { echo "OS tvarkymo klaida, darbas baigiamas."; exit; }

   #out "- Naujos VM tvarkymo kartojimas:"                   ; for ((;;)); do
   #                                                               echo -n "Ar Guest konfigūracija _jau_ tinkama? <Ne> "
   #                                                               read ANS
   #                                                               [ "$ANS" = "jau" ] && break
   #                                                               echo
   #                                                               ssh osboxes@${OAM_IP}
   #                                                           done

    out "- Naujos VM OS išjungimas:"                         ; ssh osboxes@${OAM_IP} sudo poweroff
    out "- Naujos VM tinklas išsijungia:"                    ; ping -c 6 -W 1 ${OAM_IP} | sed "1d; / ms$/! q"
    out "- Naujos VM sisteminis diskas:"                     ; VBoxManage showmediuminfo disk ${VDI_UUID}

    out "- Naujos VM išjungimas:"                            ; VBoxManage controlvm ${VM0} poweroff
                                                               until $(VBoxManage showvminfo ${VM0} | grep -q powered.off); do sleep 1; done; sleep 2
    out "- Naujos VM snapšotai:"                             ; VBoxManage snapshot ${VM0} list
    out "- Trinu VM snapšotus:"                              ; VBoxManage snapshot ${VM0} delete "${VM0_02_SSH_OK}"
                                                               VBoxManage snapshot ${VM0} delete "${VM0_01_CLEAN}"

    out "- Nuo VM atjungiamas sisteminis diskas:"            ; VBoxManage storageattach ${VM0} --storagectl "SATA valdiklis" --port 0 --device 0 --medium none
                                                               VBoxManage showvminfo --details ${VM0} | grep "^SATA valdiklis"
                                                               VBoxManage showmediuminfo disk "VMs/${VDI_FILE}" | awk '/^(UUID|State|Type|Location|In use)/'

    out "- Trinu naują VM:"                                  ; VBoxManage unregistervm ${VM0} --delete
                                                               rm -rv ${BASE_DIR}/VMs/${VM0}
    out "- Galutinės VM:"                                    ; VBoxManage list vms

    out "- Disko atvaizdį darau Multi-attach:"               ; VBoxManage modifyhd ${VDI_UUID} --type multiattach
                                                               VBoxManage showmediuminfo disk ${VDI_UUID}
    out "- Galutinis, paruoštas VDI atvaizdis:"              ; ls -l "VMs/${VDI_FILE}"
}

MSYS2_fixes
# build_gold

    VM1="VGTU-2022-DeKo-saukrs-CPVM1"                        # Bendros VM vardas
    NODE1="ubuntu1"

build_vm () {
    VMn="$1"

    out "- Pradinės VM:"                                     ; VBoxManage list vms
                                                               VBoxManage showvminfo ${VMn} > /dev/null 2>&1 && \
                                                               {
                                                                       echo
                                                                       echo "VM \"${VMn}\" jau egzistuoja, darbas stabdomas"
                                                                       exit
                                                               }
    out "- Host OS atvaizdis:"                               ; VBoxManage showmediuminfo disk "VMs/${VDI_FILE}" \
                                                                       | awk '/^UUID/ {print $2}' \
                                                                       | read VDI_UUID
                                                               VBoxManage showmediuminfo disk "VMs/${VDI_FILE}"
    out "- Nauja VM:"                                        ; VBoxManage createvm --name ${VMn} --ostype Ubuntu_64 --basefolder ${BASE_DIR}/VMs --register
    out "- Naujos VM resursų plėtimas:"                      ; VBoxManage modifyvm ${VMn} --cpus ${VM_CPUS} --memory ${VM_RAM}
    out "- Naujai VM prijungiu diskų valdiklį:"              ; VBoxManage storagectl ${VMn} --name "${VMn}-SATA" --add sata --portcount 3 --bootable on
    out "- Naujai VM prijungiu disko ataizdį:"               ; VBoxManage storageattach ${VMn} --storagectl "${VMn}-SATA" --port 0 --device 0 --type hdd --medium ${VDI_UUID}
   #out "- Naujos VM naujas NAT potinklis:"                  ; VBoxManage natnetwork add --netname "${NAT_NET_NAME}" --network "${NAT_NET_ADDR}" --enable
   #                                                           VBoxManage modifyvm ${VMn} --nic1 natnetwork --natnetwork1 "${NAT_NET_NAME}"
   #out "- Naujos VM Brige su LANu:"                         ; VBoxManage modifyvm ${VMn} --nic2 bridged --bridgeadapter2 "${IF_HOST_UPLINK}"
    out "- Naujos VM OAM tinklas:"                           ; VBoxManage modifyvm ${VMn} --nic3 hostonly --hostonlyadapter3 "${IF_HOSTONLY}"
    out "- Naujos VM startas:"                               ; VBoxManage startvm ${VMn}

    out "- Naujos VM išplėsti resursai:"                     ; VBoxManage showvminfo ${VMn} | grep -e CPUs -e Memory
    out "- Naujos VM diskinė konfigūracija:"                 ; VBoxManage showvminfo ${VMn} | grep -i storage
    out "- Naujos VM diskų valdiklio konfigūracija:"         ; VBoxManage showvminfo --details ${VMn} | grep "^${VMn}-SATA"
    out "- Naujos VM papildyta tinklo konfigūracija:"        ; VBoxManage showvminfo ${VMn} | awk '/^NIC/ && !/^NIC .* disabled/'

    out "- Naujos VM OS kyla (>10 s):"                       ; for ((i=0; i<32; i++)); do
                                                                   VBox_get_OAM_IP ${VMn} | wc -c | read CHARS
                                                                   [ ! $CHARS = 0 ] &&
                                                                       { echo " Jau!"; break; }
                                                                   sleep 1
                                                                   echo -n .
                                                               done
    out "- Naujos VM OAM IP:"                                ; VBox_get_OAM_IP ${VMn} | read OAM_IP; echo ${OAM_IP}
    out "- Naujos VM pirmas SSH prisijungimas:"              ; ssh -o StrictHostKeyChecking=no osboxes@${OAM_IP} uptime

    out "- Naujos VM OS išjungimas:"                         ; ssh osboxes@${OAM_IP} 'nohup sudo -b bash -c "sleep 2; poweroff"'
    out "- Naujos VM tinklas išsijungia:"                    ; ping -c 6 -W 1 ${OAM_IP} | sed "1d; / ms$/! q"
    out "- Naujos VM išjungimas:"                            ; VBoxManage controlvm ${VMn} poweroff && \
						       until $(VBoxManage showvminfo ${VMn} | grep -q powered.off); do echo -n .; sleep 1; done; sleep 2 || true
}

echo
echo Infrastruktūra sustatyta.
exec > /dev/tty 2>&1                                         # Stabdau išvesties dubliavimą
