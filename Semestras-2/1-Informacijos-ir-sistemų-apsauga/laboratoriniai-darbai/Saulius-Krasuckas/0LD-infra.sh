#!/bin/bash
BASE_DIR=$(builtin cd $(dirname $0); pwd)                   # Darbinė direktorija ten, kur skriptas
LOG_FILE=${BASE_DIR}/$(basename ${0%.sh}).log               # Log failo vardas pagal skripto vardą (tik pakeičiu plėtinį)

vm_list () {
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
VBoxManage showmediuminfo disk VMs/2021-VGTU-IiSA-LDVM1/2021-VGTU-IiSA-LDVM1.vdi

# VM sąrašas:
vm_list

# Kuriu 1LD mašiną:
VBoxManage createvm --name VGTU-2021-IiSA-saukrs-LDVM1 --ostype Ubuntu_64 --basefolder $BASE_DIR/VMs/ --register
vm_list
# VM konfigūracija:
VBoxManage showvminfo VGTU-2021-IiSA-saukrs-LDVM1
vm_list

# direktorija VM atvaizdams saugoti:
ls -Al VMs/
echo
ls -Al VMs/VGTU-2021-IiSA-saukrs-LDVM*

VBoxManage unregistervm --delete VGTU-2021-IiSA-saukrs-LDVM1
ls -Al VMs/
exec > /dev/tty 2>&1                                        # Stabdau išvesties dubliavimą
