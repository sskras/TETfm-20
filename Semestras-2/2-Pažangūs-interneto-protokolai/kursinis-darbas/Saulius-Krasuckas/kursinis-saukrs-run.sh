#!/bin/bash

shopt -s lastpipe

echo "$(basename $0): Startuoju, cmd-line: "$*
DIR=$(dirname $0)

LOSS="0.00"
echo "$LOSS * 100" | bc -q | xargs printf "%d\n" | read LOSS_P

# Vėlinimas pagal kursinio darbo užduotį, ms:
for DELAY in 2 6 80; do
#   ns $DIR/kursinis-saukrs.tcl -- "${DELAY}ms" ${LOSS} "kursinis-saukrs_HSTCP_+_BIC,_${DELAY}ms_${LOSS_P}%-loss" \
    ns $DIR/kursinis-saukrs.tcl -- "${DELAY}ms" ${LOSS} "kursinis-saukrs" \
        0.1 '$ftp1 start' \
        0.2 '$ftp2 start' \
        290 '$ftp1 stop'  \
        290 '$ftp2 stop'  \
        300 'finish'
    echo
    echo Išsitraukiame tiriamosios linijos duomenis:
    ls -l kursinis-saukrs.tr
    cat kursinis-saukrs.tr | grep '^r .* 2 3' | awk -f $DIR/../tools/NS-2/Throughput.awk
    # TODO: atskirti reziume spausdinimą ir packet_size(t) ištraukimą į stderr + stdout
    echo
done

ls -l *.{tr,nam}
echo "Trinam?"; read
rm -v *.{tr,nam}
