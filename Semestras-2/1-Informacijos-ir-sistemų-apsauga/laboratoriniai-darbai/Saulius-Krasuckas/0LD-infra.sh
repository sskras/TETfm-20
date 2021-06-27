#!/bin/bash
LOG_FILE=0LD-infra.log
exec > >(tee -i "${LOG_FILE}") 2>&1                         # Dubliuoju išvestį į logą
echo ${0%.sh}.log
VBoxManage list vms
exec > /dev/tty 2>&1                                        # Stabdau išvesties dubliavimą
