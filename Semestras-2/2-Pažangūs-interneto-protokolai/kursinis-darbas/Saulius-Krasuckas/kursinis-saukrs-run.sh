#!/bin/bash

shopt -s lastpipe

DIR=$(dirname $0)

LOSS="0.00"
echo "$LOSS * 100" | bc -q | xargs printf "%d\n" | read LOSS_P

# Vėlinimas pagal kursinio darbo užduotį, ms:
for DELAY in 2 6 80; do
#   ns $DIR/kursinis-saukrs.tcl -- "${DELAY}ms" ${LOSS} "kursinis-saukrs_HSTCP_+_BIC,_${DELAY}ms_${LOSS_P}%-loss" \
    ns $DIR/kursinis-saukrs.tcl -- "${DELAY}ms" ${LOSS} "kursinis-saukrs" \
        0.1 '$ftp1 start' \
        0.2 '$ftp2 start' \
        2.0 '$ftp1 stop'  \
        2.0 '$ftp2 stop'  \
        3.0 'finish'
    echo
    echo Išsitraukiame tiriamosios linijos duomenis:
    ls -l kursinis-saukrs.tr
    cat kursinis-saukrs.tr | grep '^r .* 2 3' | awk -f $DIR/../tools/NS-2/Throughput.awk 1>kursinis-saukrs.throughput.txt
    # TODO: atskirti reziume spausdinimą ir packet_size(t) ištraukimą į stderr + stdout
    echo
done

ls -l *.{tr,nam}
echo "Trinam?"; read
rm -v *.{tr,nam}
