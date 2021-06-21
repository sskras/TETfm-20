#!/bin/bash

shopt -s lastpipe

echo "$(basename $0): Startuoju, cmd-line: "$*
DIR=$(dirname $0)

FNAME_PREFIX="saukrs-abu-srautai-kartu"
LOSS="0.00"
echo "$LOSS * 100" | bc -q | xargs printf "%d\n" | read LOSS_P

for DELAY in 0 2 4; do
    echo "Skaičiuoju pagal \$DELAY=$DELAY"
#   ns $DIR/kursinis-saukrs.tcl -- "${DELAY}ms" ${LOSS} "kursinis-saukrs" \
    ns $DIR/kursinis-saukrs.tcl -- "${DELAY}ms" ${LOSS} "${FNAME_PREFIX}_HSTCP_+_BIC,_${DELAY}ms_${LOSS_P}%-loss" \
        0.1 '$ftp1 start' \
        0.2 '$ftp2 start' \
        2.90 '$ftp1 stop'  \
        2.90 '$ftp2 stop'  \
        3.00 'finish'
    echo
done

ls -l *.{tr,nam}
echo "Trinam?"; read
rm -v *.{tr,nam}
