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

PATH=$PATH:/C/Program\ Files/Oracle/VirtualBox

VM_CPUS=2                                                   # VM CPU skaičius
VM_RAM=1024                                                 # VM RAM apimtis
VM0="VGTU-2022-DeKo-saukrs-LDVM0"                           # Bendros VM vardas


exec > >(tee -i "${LOG_FILE}") 2>&1                         # Dubliuoju išvestį į logą


VBox_setup_serial_console () {
    # Pristabdau nurodytą VMą keisti jo Boot Loader nustatymams:
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
    > ${UART_SCR}

    # Jungiamės prie virtualios Serial konsolės per TCP:
    script -c "echo; telnet 127.0.0.1 23001" ${UART_SCR}

    # Išsaugome Serial konsolės logą Plain-text formatu:
    cat ${UART_SCR} | ansifilter |  sed '1d;$d' > ${UART_LOG}
}


echo "$(basename $0): Startuojama infrastruktūra"

   #echo; VBoxManage list vms
   #echo; VBoxManage createvm --name ${VM0} --ostype Ubuntu_64 --basefolder ${BASE_DIR}/VMs --register
   #echo; VBoxManage list vms

    echo; VBoxManage unregistervm ${VM0} --delete
    echo; VBoxManage list vms

# VBox_setup_serial_console ${VM0}


exec > /dev/tty 2>&1                                        # Stabdau išvesties dubliavimą
