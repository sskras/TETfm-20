#!/bin/bash

shopt -s lastpipe

echo "$0: Startuoju, cmd-line: "$*

FNAME_PREFIX="saukrs-bandomasis"

DELAY="2"; LOSS="0.00"
echo "$LOSS * 100" | bc -q | xargs printf "%d\n" | read LOSS_P
ns kursinis-saukrs.tcl -- "${DELAY}ms" ${LOSS} "${FNAME_PREFIX}_HSTCP_+_BIC,_${DELAY}ms_${LOSS_P}%-loss"
echo

DELAY="4"; LOSS="0.00"
ns kursinis-saukrs.tcl -- "${DELAY}ms" ${LOSS} "${FNAME_PREFIX}_HSTCP_+_BIC,_${DELAY}ms_${LOSS_P}%-loss"
echo

ls -l *.{tr,nam}
echo "Trinam?"; read
rm -v *.{tr,nam}
