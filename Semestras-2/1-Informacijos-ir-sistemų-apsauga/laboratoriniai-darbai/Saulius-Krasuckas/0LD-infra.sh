#!/bin/bash
BASE_DIR=$(builtin cd $(dirname $0); pwd)                   # Darbinė direktorija ten, kur skriptas
LOG_FILE=${BASE_DIR}/$(basename ${0%.sh}).log               # Log failo vardas pagal skripto vardą (tik pakeičiu plėtinį)

vm_list () {
    VBoxManage list vms | awk '{GUID=$NF; $NF=""; sub(/ $/, ""); print GUID" "$0}'
}

exec > >(tee -i "${LOG_FILE}") 2>&1                         # Dubliuoju išvestį į logą

# VM sąrašas:
vm_list

# Kuriu 1LD mašiną:
VBoxManage createvm --name VGTU-2021-IiSA-saukrs-LDVM1 --ostype Ubuntu_64 --basefolder $BASE_DIR/VMs/ --register
VBoxManage showvminfo VGTU-2021-IiSA-saukrs-LDVM1 | grep "Config file"
VBoxManage unregistervm --delete VGTU-2021-IiSA-saukrs-LDVM1

# direktorija VM atvaizdams saugoti:
pwd
ls -Al VMs/

exec > /dev/tty 2>&1                                        # Stabdau išvesties dubliavimą
