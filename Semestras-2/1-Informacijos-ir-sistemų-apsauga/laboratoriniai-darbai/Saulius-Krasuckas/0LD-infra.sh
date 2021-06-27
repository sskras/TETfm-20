#!/bin/bash
exec > >(tee -i 0LD-infra.log) 2>&1                         # Dubliuoju išvestį į logą
exec > /dev/tty 2>&1                                        # Stabdau išvesties dubliavimą
