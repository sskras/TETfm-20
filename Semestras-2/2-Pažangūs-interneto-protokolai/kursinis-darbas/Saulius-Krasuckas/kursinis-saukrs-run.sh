#!/bin/bash

shopt -s lastpipe

echo "$0: Startuoju, cmd-line: "$*

FNAME_PREFIX="saukrs-bandomasis"

LOSS="0.00"
echo "$LOSS * 100" | bc -q | xargs printf "%d\n" | read LOSS_P

for DELAY in 2 4; do
    echo "Skaičiuoju pagal \$DELAY=$DELAY"
    ns kursinis-saukrs.tcl -- "${DELAY}ms" ${LOSS} "${FNAME_PREFIX}_HSTCP_+_BIC,_${DELAY}ms_${LOSS_P}%-loss"
    echo
done

echo

ls -l *.{tr,nam}
echo "Trinam?"; read
rm -v *.{tr,nam}
