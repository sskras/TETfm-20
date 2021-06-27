#!/bin/bash
BASE_DIR=${0%.sh}                                           # Darbinė direktorija ten, kur skriptas
LOG_FILE=${BASE_DIR}.log                                    # Log failo vardas pagal skripto vardą (tik pakeičiu plėtinį)

exec > >(tee -i "${LOG_FILE}") 2>&1                         # Dubliuoju išvestį į logą

# VM sąrašas:
VBoxManage list vms | awk '{GUID=$NF; $NF=""; sub(/ $/, ""); print GUID" "$0}'

# Kuriu 1LD mašiną:
VBoxManage createvm --name VGTU-2021-IiSA-saukrs-LDVM1 --ostype Ubuntu_64 --basefolder ./VMs/ --register
VBoxManage showvminfo VGTU-2021-IiSA-saukrs-LDVM1 | grep "Config file"

# direktorija VM atvaizdams saugoti:
pwd
ls -Al VMs/

exec > /dev/tty 2>&1                                        # Stabdau išvesties dubliavimą
