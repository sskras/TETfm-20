#!/usr/bin/env bash
#
# 2022-01-31 saukrs: Pradedu kursinį darbą.
#
# Kopijuosiu skripto dalis iš praėjusio semestro IiSA laboratorinių darbų:
# https://github.com/VGTU-ELF/TETfm-20/blob/main/Semestras-2/1-Informacijos-ir-sistem%C5%B3-apsauga/laboratoriniai-darbai/Saulius-Krasuckas/0LD-infra.sh

BASE_DIR=$(builtin cd $(dirname $0); pwd)                   # Darbinė direktorija ten, kur skriptas
LOG_FILE=${BASE_DIR}/$(basename ${0%.sh}).log               # Log failo vardas pagal skripto vardą (tik pakeičiu plėtinį)

UART_SCR=${LOG_FILE%.log}-serial.script                     # Script failas VMų Serial/UART konsolei
UART_LOG=${LOG_FILE%.log}-serial.log                        # Log failas VMų Serial/UART konsolei
UART_TCP_PORT="23001"                                       # Host TCP prievadas, skirtas ryšiui su konsole
UART_I_O_PORT="0x3f8"                                       # VM Serial/UART I/O prievadas (aparatinis)

PATH=$PATH:/C/Program\ Files/Oracle/VirtualBox

VM_CPUS=2                                                   # VM CPU skaičius
VM_RAM=1024                                                 # VM RAM apimtis
VM0="VGTU-2022-DeKo-saukrs-LDVM0"                           # Bendros VM vardas

VDI_URL="https://sourceforge.net/projects/osboxes/files/v/vb/55-U-u/20.04/20.04.3/Desktop/64bit.7z/download"
VDI_ZIP="Ubuntu-20.04.3-Desktop-64bit.7z"


shopt -s lastpipe

exec > >(tee -i "${LOG_FILE}") 2>&1                         # Dubliuoju išvestį į logą


VBox_setup_serial_console () {
    echo
    echo "VM lange Spauskite kombinaciją <Host-P>, tuomet <Esc>"
    echo "Kartokite <Esc> paspaudimus be perstojo."
    echo "Kai pasirodys GRUB meniu, spauskite <e>"
    echo "Eikite žemyn iki eilutės:"
    echo "        linux        /boot/vmlinuz-..."
    echo
    echo "Spauskite <End> ir gale prirašykite:"
    echo
    echo "... console=ttyS0,115200n8"
    echo
    echo "VM paspauskite <Ctrl-X>"
    echo
    echo "Iškart persijunkite čia (atgal į CLI)"
    echo "... ir spauskite <Enter>"
    echo
    echo "Prisijungsite prie Serial konsolės:"

    read

    # Išvalau būsimą Serial logą:
    > ${UART_SCR}

    # Jungiamės prie virtualios Serial konsolės per TCP:
    script -c "echo; telnet 127.0.0.1 23001" ${UART_SCR}

    # Išsaugome Serial konsolės logą Plain-text formatu:
    cat ${UART_SCR} | ansifilter |  sed '1d;$d' > ${UART_LOG}
}


echo "$(basename $0): Startuojama infrastruktūra"

                                                               cd ${BASE_DIR}/VMs
    echo -e "\n- Host OS atvaizdžio parsiuntimas:\n"         ; curl -LC - -o ${VDI_ZIP} ${VDI_URL}
    echo -e "\n- Host OS atvaizdžio išspaudimas:\n"          ; time bsdtar -xvkf ${VDI_ZIP}
                                                               bsdtar -tvf ${VDI_ZIP} | awk '/vdi$/ {$1=$2=$3=$4=$5=$6=$7=$8=""; print}' | read VDI_FILE
    echo -e "\n- Host OS atvaizdis:\n"                       ; echo "${VDI_FILE}"
    echo -e "\n- Host OS atvaizdžio informacija:\n"          ; VBoxManage showmediuminfo disk "${VDI_FILE}"
                                                               VBoxManage showmediuminfo disk "${VDI_FILE}" | awk '/^UUID/ {print $2}' | read VDI_UUID
    echo -e "\n- Host OS atvaizdžio ID:\n"                   ; echo "${VDI_UUID}"
                                                               cd - > /dev/null

    echo -e "\n- Pradinės VM:\n"                             ; VBoxManage list vms
    echo -e "\n- Nauja VM:\n"                                ; VBoxManage createvm --name ${VM0} --ostype Ubuntu_64 --basefolder ${BASE_DIR}/VMs --register
    echo -e "\n- Dabartinės VM:\n"                           ; VBoxManage list vms

    echo -e "\n- Naujos VM pirminė konfigūracija:\n"         ; VBoxManage showvminfo ${VM0} | grep -e CPUs -e Memory
    echo -e "\n- Naujos VM resursų plėtimas:\n"              ; VBoxManage modifyvm ${VM0} --cpus ${VM_CPUS} --memory ${VM_RAM}
    echo -e "\n- Naujos VM išplėsti resursai:\n"             ; VBoxManage showvminfo ${VM0} | grep -e CPUs -e Memory

    echo -e "\n- Naujai VM prijungiu diskų valdiklį:\n"      ; VBoxManage storagectl ${VM0} --name "SATA valdiklis" --add sata --bootable on
    echo -e "\n- Naujos VM diskinė konfigūracija:\n"         ; VBoxManage showvminfo ${VM0} | grep -i storage

    echo -e "\n- Naujai VM prijungiu disko ataizdį:\n"       ; VBoxManage storageattach ${VM0} --storagectl "SATA valdiklis" --port 0 --device 0 --type hdd --medium ${VDI_UUID}
    echo -e "\n- Naujos VM diskų valdiklio konfigūracija:\n" ; VBoxManage showvminfo --details ${VM0} | grep "^SATA valdiklis"

    echo -e "\n- Naujos VM Serial konsolė:\n"                ; VBoxManage modifyvm ${VM0} --uart ${UART_I_O_PORT} --uartmodel tcpserver ${UART_TCP_PORT}
    echo -e "\n! VM sukurta, metas pasitikrinti jos būseną"
    echo -e "\n- Naujos VM startas:\n"                       ; VBoxManage startvm ${VM0}
    echo -e "\n- Naują VM pristabdau:\n"                     ; VBoxManage controlvm ${VM0} pause
    echo -e "\n- Naujos VM konsolės logas:\n"                ; VBox_setup_serial_console ${VM0}

    echo -e "\n! Po <Enter> ji bus išjungta ir ištrinta:"    ; read
    echo -e "\n- Naujos VM išjungimas:\n"                    ; VBoxManage controlvm ${VM0} poweroff
                                                               until $(VBoxManage showvminfo ${VM0} | grep -q powered.off); do sleep 1; done; sleep 1

    echo -e "\n- Trinu naują VM:\n"                          ; VBoxManage unregistervm ${VM0} --delete
    echo -e "\n- Galutinės VM:\n"                            ; VBoxManage list vms


exec > /dev/tty 2>&1                                        # Stabdau išvesties dubliavimą
