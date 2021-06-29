#!/bin/bash

BASE_DIR=$(builtin cd $(dirname $0); pwd)                   # Darbinė direktorija ten, kur skriptas
LOG_FILE=${BASE_DIR}/$(basename ${0%.sh}).log               # Log failo vardas pagal skripto vardą (tik pakeičiu plėtinį)
LOG_UART=${LOG_FILE%.log}-serial.log                        # Log failas VMų Serial/UART konsolei
VDI_UUID=""                                                 # Laikys pagrindinio visų VMų multi-attach disko UUID
VM0="VGTU-2021-IiSA-saukrs-LDVM0"                           # Bendros VM vardas
VM1="VGTU-2021-IiSA-saukrs-LDVM1"                           # Pirmos VM vardas

shopt -s lastpipe

exec > >(tee -i "${LOG_FILE}") 2>&1                         # Dubliuoju išvestį į logą

VBoxManage_vm_list () {
    VBoxManage list vms | awk '{GUID=$NF; $NF=""; sub(/ $/, ""); print GUID" "$0}'
}

VBoxManage_get_VDI_image () {                               # Kuriu VDI atvaizdą atskiroje funkcijoje
    cd $BASE_DIR/VMs

    # Šį failą reikėtų automatiškai pervadinti, kad netrukdytų curl raktui -J:
    # mv -bv 64bit.7z <TODO>

    # Ubuntu Desktop 21.04 Linux OS .vdi atvaizdas:
    # curl -OLv https://sourceforge.net/projects/osboxes/files/v/vb/55-U-u/21.04/64bit.7z/download
    #
    # Ubuntu Server 20.04.2 LTS .vdi atvaizdas:
    # curl -OLv https://sourceforge.net/projects/osboxes/files/v/vb/59-U-u-svr/20.04/20.04.2/64bit.7z/download
    #
    # Ubuntu Desktop 20.04.2 Focal Fossa (LTS) .vdi atvaizdas:
    # curl -OLJv https://sourceforge.net/projects/osboxes/files/v/vb/55-U-u/20.04/20.04.2/64bit.7z/download

    # TODO rasti būdą kaip išsirinkti, kurį Image naudosime:
    # TODO (kol kas atstatau 64bit.7z kaip Symbolic Link)
    7za l 64bit.7z | awk '/vdi$/ {$1=$2=$3=$4=$5=""; print}' | read VDI_FILE
    echo "Ištrauktojo VDI disko pavadinimas: ${VDI_FILE}"
    # time 7za x 64bit.7z
    cd -

    ls -Al $BASE_DIR/VMs/64bit

    # Patikrinkim disko informaciją:
    # (ši užklausa automatiškai užregistruoja .vdi failą VBox registre, jei jo ten dar nebuvo:
    VBoxManage showmediuminfo disk "VMs/${VDI_FILE}"
    VBoxManage showmediuminfo disk "VMs/${VDI_FILE}" | awk '/^UUID/ {print $2}' | read VDI_UUID
    echo
}

VBoxManage_createvm () {                                    # Kuriu VM atskiroje funkcijoje
    # VM sąrašas:
    VBoxManage_vm_list
    echo

    # Kuriu 1LD mašiną:
    VBoxManage createvm --name ${1} --ostype Ubuntu_64 --basefolder $BASE_DIR/VMs/ --register
    VBoxManage_vm_list
    echo

    # VM konfigūracija:
    VBoxManage showvminfo ${1}
    echo "Sena procesoriaus ir RAM konfigūracija:"
    VBoxManage showvminfo ${1} | grep -e CPUs -e Memory
    echo

    # Padidinu CPU skaičių ir RAM apimtį, tik neturiu 4ių GiB šioje fizinėje mašinoje:
    # https://help.ubuntu.com/community/Installation/SystemRequirements
    VBoxManage modifyvm ${1} --cpus 2 --memory 2048
    echo "Nauja procesoriaus ir RAM konfigūracija:"
    VBoxManage showvminfo ${1} | grep -e CPUs -e Memory
    echo

    # Prijungiu disko valdiklį:
    VBoxManage storagectl ${1} --name "SATA valdiklis" --add sata --bootable on

    # Prie valdiklio prijungiu išspaustą .VDI kaip naują diską:
    # TODO išsitraukti UUID iš naujai išspausto .VDI ir perduoti per CLI:
    echo "Nauja SATA konfigūracija:"
    VBoxManage storageattach ${1} --storagectl "SATA valdiklis" --port 0 --device 0 --type hdd --medium ${VDI_UUID}
    echo "Nauja diskų valdiklio konfigūracija:"
    VBoxManage showvminfo ${1} | grep -i storage
    echo

    # Sukuriu Host-only interfeisą Host pusėje:
    VBoxManage hostonlyif create
    VBoxManage list hostonlyifs | awk '/^Name/ {NEWEST_NIC=$2} END {print NEWEST_NIC}' | read HOSTONLY_IF
    # Pasirenku bet kurį iš LD2 nurodytų IP adresų: 192.168.10.x:
    VBoxManage hostonlyif ipconfig ${HOSTONLY_IF} --ip 192.168.10.8
    echo "Naujas Host-only NIC:"
    VBoxManage list hostonlyifs | awk '/'${HOSTONLY_IF}'/ {START=1} START && $0=="" {START=0} START {print}'
    echo

    # Prijungiu jį prie NIC 2: (OAM valdymui per tinklą)
    VBoxManage modifyvm ${1} --nic2 hostonly --hostonlyadapter2 ${HOSTONLY_IF}
    echo "Nauja NIC konfigūracija:"
    VBoxManage showvminfo ${1} | grep NIC
    echo

    # Prijungiu Serial UART: (valdymui be tinklo)
    VBoxManage modifyvm ${1} --uart1 "0x3f8" 4 --uartmode1 tcpserver 23001
    echo "Nauja UART konfigūracija:"
    VBoxManage showvminfo ${1} | grep UART
    echo
}
# Ir jos dabar nebekviečiu, nes VM jau puikiai sudėliota

VBoxManage_setup_serial_console () {
    # ... ir ją pristabdau Boot Loader nustatymams:
    VBoxManage controlvm ${1} pause
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
    > screenlog.0

    # Jungiamės prie virtualios Serial konsolės per TCP:
    screen -L telnet 127.0.0.1 23001

    # Išsaugome Serial konsolės logą Plain-text formatu:
    cat screenlog.0 | ansifilter > ${LOG_UART}
}

VBoxManage_show_vm_details () {                             # VM detales rodau irgi atskiroje funkcijoje
    # direktorija VM atvaizdams saugoti:
    ls -Al VMs/
    echo
    ls -Al VMs/${1}*

    VBoxManage showvminfo ${1}
}

VBoxManage_deletevm () {                                    # Naikinu VM irgi atskiroje funkcijoje
    echo "Trinam ${1} ?"
    read

    VBoxManage unregistervm ${1}
    VBoxManage hostonlyif remove ${HOSTONLY_IF}
    # Išvalau individualius VM likučius:
    rm -rv ${BASE_DIR}/VMs/${1}

    VBoxManage_vm_list
    ls -Al VMs/
    # Paliekame bendrą disko .vdi atvaizdą (kitoje direktorijoje) kaip etaloninį
}

VBoxManage_start () {
    echo "Įjungiu ${1}:"
    VBoxManage startvm ${1}
}

VBoxManage_detach_VDI_from_VM () {
    VBoxManage showmediuminfo disk ${2} | grep -e UUID

    # Nuo valdiklio atjungiu .VDI atvaizdą/diską:
    VBoxManage storageattach ${1} --storagectl "SATA valdiklis" --port 0 --device 0 --medium "none"
    echo "SATA konfigūracija po atjungimo:"
    VBoxManage showvminfo ${1} | grep -i -e Storage -e SATA
    echo
    VBoxManage showmediuminfo disk ${2} | grep -e UUID
}

VBoxManage_attach_VDI_to_VM () {
    VBoxManage storageattach ${1} --storagectl "SATA valdiklis" --port 0 --device 0 --type hdd --medium ${2}

    echo "SATA konfigūracija po sugrąžinimo:"
    VBoxManage showvminfo ${1} | grep -i -e Storage -e SATA
    echo
    VBoxManage showmediuminfo disk ${2} | grep -e UUID
}

#VBoxManage_createvm ${VM0}
#VBoxManage_setup_serial_console ${VM0}
#VBoxManage_deletevm ${VM0}

VBoxManage_get_VDI_image
VBoxManage_detach_VDI_from_VM ${VM0} ${VDI_UUID}
VBoxManage modifyhd ${VDI_UUID} --type multiattach
VBoxManage modifyvm ${VM1} --name ${VM0}
VBoxManage_createvm ${VM1}
VBoxManage_attach_VDI_to_VM ${VM1} ${VDI_UUID}
VBoxManage_start ${VM1}
echo "Palaukime VM išsijungimo?"
read
VBoxManage_show_vm_details ${VM1}

exec > /dev/tty 2>&1                                        # Stabdau išvesties dubliavimą
