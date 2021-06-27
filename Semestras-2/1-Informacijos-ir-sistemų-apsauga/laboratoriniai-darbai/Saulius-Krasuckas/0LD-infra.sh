#!/bin/bash
LOG_FILE=0LD-infra.log
exec > >(tee -i "${LOG_FILE}") 2>&1                         # Dubliuoju išvestį į logą
VBoxManage list vms
exec > /dev/tty 2>&1                                        # Stabdau išvesties dubliavimą
