#!/bin/bash

shopt -s lastpipe

echo "$(basename $0): Startuoju, cmd-line: "$*
DIR=$(dirname $0)

FNAME_PREFIX="saukrs-abu-srautai-kartu"
LOSS="0.00"
echo "$LOSS * 100" | bc -q | xargs printf "%d\n" | read LOSS_P

for DELAY in 0 2 4; do
    echo "Skaičiuoju pagal \$DELAY=$DELAY"
    ns $DIR/kursinis-saukrs.tcl -- "${DELAY}ms" ${LOSS} "${FNAME_PREFIX}_HSTCP_+_BIC,_${DELAY}ms_${LOSS_P}%-loss" \
        '$ftp1 start' \
        '$ftp2 start' \
        ;
    echo
done

ls -l *.{tr,nam}
echo "Trinam?"; read
rm -v *.{tr,nam}
