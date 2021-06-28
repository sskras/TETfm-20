#!/bin/bash
BASE_DIR=$(builtin cd $(dirname $0); pwd)                   # Darbinė direktorija ten, kur skriptas
LOG_FILE=${BASE_DIR}/$(basename ${0%.sh}).log               # Log failo vardas pagal skripto vardą (tik pakeičiu plėtinį)
VM1="VGTU-2021-IiSA-saukrs-LDVM1"                           # Pirmos VM vardas

VBoxManage_vm_list () {
    VBoxManage list vms | awk '{GUID=$NF; $NF=""; sub(/ $/, ""); print GUID" "$0}'
}

exec > >(tee -i "${LOG_FILE}") 2>&1                         # Dubliuoju išvestį į logą

# Ubuntu 21.04 Linux OS .vdi atvaizdas:
# cd $BASE_DIR/VMs
# curl -OLv https://sourceforge.net/projects/osboxes/files/v/vb/55-U-u/21.04/64bit.7z/download
# time 7za x 64bit.7z
# cd -

ls -Al $BASE_DIR/VMs/64bit

# Patikrinkim disko informaciją:
# (ši užklausa automatiškai užregistruoja .vdi failą VBox registre, jei jo ten dar nebuvo:
VBoxManage showmediuminfo disk "VMs/64bit/Ubuntu 21.04 (64bit).vdi"

# VM sąrašas:
VBoxManage_vm_list

# Kuriu 1LD mašiną:
VBoxManage createvm --name ${VM1} --ostype Ubuntu_64 --basefolder $BASE_DIR/VMs/ --register
VBoxManage_vm_list

# VM konfigūracija:
VBoxManage showvminfo ${VM1}
echo "Sena procesoriaus ir RAM konfigūracija:"
VBoxManage showvminfo ${VM1} | grep -e CPUs -e Memory

# Padidinu CPU skaičių ir RAM apimtį, tik neturiu 4ių GiB šioje fizinėje mašinoje:
# https://help.ubuntu.com/community/Installation/SystemRequirements
VBoxManage modifyvm ${VM1} --cpus 2 --memory 2048
echo "Nauja procesoriaus ir RAM konfigūracija:"
VBoxManage showvminfo ${VM1} | grep -e CPUs -e Memory

# Prijungiu disko valdiklį:
VBoxManage storagectl ${VM1} --name "SATA valdiklis" --add sata --bootable on
VBoxManage showvminfo ${VM1} | grep -i storage

# Prie valdiklio prijungiu išspaustą .VDI kaip naują diską:
# TODO išsitraukti UUID iš naujai išspausto .VDI ir perduoti per CLI:
VBoxManage storageattach ${VM1} --storagectl "SATA valdiklis" --port 0 --device 0 --type hdd --medium 1c4fb197-350c-4202-9588-587f79276d90

# Prijungiu Serial UART: (valdymui be tinklo)
VBoxManage modifyvm ${VM1} --uart1 "0x3f8" 4 --uartmode1 tcpserver 23001

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
echo "Ir spauskite <Ctrl-X>"
read


# direktorija VM atvaizdams saugoti:
ls -Al VMs/
echo
ls -Al VMs/VGTU-2021-IiSA-saukrs-LDVM*

VBoxManage showvminfo ${VM1}

echo "Trinam ${VM1} ?"
read

VBoxManage unregistervm ${VM1}
# Išvalau individualius VM likučius:
rm -rv ${BASE_DIR}/VMs/${VM1}
VBoxManage_vm_list
ls -Al VMs/
exec > /dev/tty 2>&1                                        # Stabdau išvesties dubliavimą
