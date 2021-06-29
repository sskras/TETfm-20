#!/bin/bash

BASE_DIR=$(builtin cd $(dirname $0); pwd)                   # Darbinė direktorija ten, kur skriptas
LOG_FILE=${BASE_DIR}/$(basename ${0%.sh}).log               # Log failo vardas pagal skripto vardą (tik pakeičiu plėtinį)
LOG_UART=${LOG_FILE%.log}-serial.log                        # Log failas VMų Serial/UART konsolei
VM1="VGTU-2021-IiSA-saukrs-LDVM1"                           # Pirmos VM vardas

shopt -s lastpipe

VBoxManage_vm_list () {
    VBoxManage list vms | awk '{GUID=$NF; $NF=""; sub(/ $/, ""); print GUID" "$0}'
}

exec > >(tee -i "${LOG_FILE}") 2>&1                         # Dubliuoju išvestį į logą

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

# VM sąrašas:
VBoxManage_vm_list
echo

# Kuriu 1LD mašiną:
VBoxManage createvm --name ${VM1} --ostype Ubuntu_64 --basefolder $BASE_DIR/VMs/ --register
VBoxManage_vm_list
echo

# VM konfigūracija:
VBoxManage showvminfo ${VM1}
echo "Sena procesoriaus ir RAM konfigūracija:"
VBoxManage showvminfo ${VM1} | grep -e CPUs -e Memory
echo

# Padidinu CPU skaičių ir RAM apimtį, tik neturiu 4ių GiB šioje fizinėje mašinoje:
# https://help.ubuntu.com/community/Installation/SystemRequirements
VBoxManage modifyvm ${VM1} --cpus 2 --memory 2048
echo "Nauja procesoriaus ir RAM konfigūracija:"
VBoxManage showvminfo ${VM1} | grep -e CPUs -e Memory
echo

# Prijungiu disko valdiklį:
VBoxManage storagectl ${VM1} --name "SATA valdiklis" --add sata --bootable on

# Prie valdiklio prijungiu išspaustą .VDI kaip naują diską:
# TODO išsitraukti UUID iš naujai išspausto .VDI ir perduoti per CLI:
echo "Nauja SATA konfigūracija:"
VBoxManage storageattach ${VM1} --storagectl "SATA valdiklis" --port 0 --device 0 --type hdd --medium ${VDI_UUID}
echo "Nauja diskų valdiklio konfigūracija:"
VBoxManage showvminfo ${VM1} | grep -i storage
echo

# Sukuriu Host-only interfeisą Host pusėje:
VBoxManage hostonlyif create
VBoxManage list hostonlyifs | awk '/^Name/ {NEWEST_NIC=$2} END {print NEWEST_NIC}' | read HOSTONLY_IF
VBoxManage dhcpserver modify --interface=${HOSTONLY_IF} --disable
VBoxManage hostonlyif ${HOSTONLY_IF} --ip 192.168.10.8
echo "Naujas Host-only NIC:"
VBoxManage list hostonlyifs | awk '/'${HOSTONLY_IF}'/ {START=1} START && $0=="" {START=0} START {print}'
echo

# Prijungiu jį prie NIC 2: (OAM valdymui per tinklą)
VBoxManage modifyvm ${VM1} --nic2 hostonly --hostonlyadapter2 ${HOSTONLY_IF}
echo "Nauja NIC konfigūracija:"
VBoxManage showvminfo ${VM1} | grep NIC
echo

# Prijungiu Serial UART: (valdymui be tinklo)
VBoxManage modifyvm ${VM1} --uart1 "0x3f8" 4 --uartmode1 tcpserver 23001
echo "Nauja UART konfigūracija:"
VBoxManage showvminfo ${VM1} | grep UART
echo

# Įjungiu 1LD mašiną:
echo "Įjungiu ${VM1}:"
VBoxManage startvm ${VM1}
# ... ir ją pristabdau Boot Loader nustatymams:
VBoxManage controlvm ${VM1} pause
echo
echo "VM lange Spauskite kombinaciją <Host-P>, tuomet <Esc>"
echo "Kartokite <Esc> paspaudimus be perstojo."
echo "Kai pasirodys GRUB meniu, spauskite <e>"
echo "Eikite žemyn iki eilutės:"
echo "        linux        /boot/vmlinuz-..."
echo
echo "Spauskite <End> ir gale prirašykite:"
echo
echo "... console=tty0 console=ttyS0,115200n8"
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

# direktorija VM atvaizdams saugoti:
ls -Al VMs/
echo
ls -Al VMs/VGTU-2021-IiSA-saukrs-LDVM*

VBoxManage showvminfo ${VM1}

echo "Trinam ${VM1} ?"
read

VBoxManage unregistervm ${VM1}
VBoxManage hostonlyif remove ${HOSTONLY_IF}
# Išvalau individualius VM likučius:
rm -rv ${BASE_DIR}/VMs/${VM1}
VBoxManage_vm_list
ls -Al VMs/
exec > /dev/tty 2>&1                                        # Stabdau išvesties dubliavimą
