#!/usr/bin/env bash
#
# 2022-01-31 saukrs: Pradedu kursinį darbą.
#
# Kopijuosiu skripto dalis iš praėjusio semestro IiSA laboratorinių darbų:
# https://github.com/VGTU-ELF/TETfm-20/blob/main/Semestras-2/1-Informacijos-ir-sistem%C5%B3-apsauga/laboratoriniai-darbai/Saulius-Krasuckas/0LD-infra.sh

BASE_DIR=$(builtin cd $(dirname $0); pwd)                   # Darbinė direktorija ten, kur skriptas
LOG_FILE=${BASE_DIR}/$(basename ${0%.sh}).log               # Log failo vardas pagal skripto vardą (tik pakeičiu plėtinį)
LOG_UART=${LOG_FILE%.log}-serial.log                        # Log failas VMų Serial/UART konsolei

exec > >(tee -i "${LOG_FILE}") 2>&1                         # Dubliuoju išvestį į logą

echo "Startuojama infrastruktūra"

exec > /dev/tty 2>&1                                        # Stabdau išvesties dubliavimą
