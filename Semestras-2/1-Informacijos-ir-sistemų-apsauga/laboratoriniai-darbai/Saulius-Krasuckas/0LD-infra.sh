#!/bin/bash
LOG_FILE=${0%.sh}.log                                       # Log failo vardas pagal skripto vardą (tik pakeičiu plėtinį)

exec > >(tee -i "${LOG_FILE}") 2>&1                         # Dubliuoju išvestį į logą

# VM sąrašas:
VBoxManage list vms | awk '{GUID=$NF; $NF=""; sub(/ $/, ""); print GUID" "$0}'

# direktorija VM atvaizdams saugoti:
pwd
ls -Al VMs/

# Kuriu 1LD mašiną:
VBoxManage createvm --name VGTU-2021-IiSA-saukrs-LDVM1 --ostype Ubuntu_64 --basefolder VMs/ --register

exec > /dev/tty 2>&1                                        # Stabdau išvesties dubliavimą
