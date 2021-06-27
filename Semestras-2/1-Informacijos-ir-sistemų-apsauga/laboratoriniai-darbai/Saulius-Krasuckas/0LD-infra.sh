#!/bin/bash
LOG_FILE=${0%.sh}.log                                       # Log failo vardas pagal skripto vardą (tik pakeičiu plėtinį)

exec > >(tee -i "${LOG_FILE}") 2>&1                         # Dubliuoju išvestį į logą

# VM sąrašas:
VBoxManage list vms | awk '{print $NF}'

exec > /dev/tty 2>&1                                        # Stabdau išvesties dubliavimą
