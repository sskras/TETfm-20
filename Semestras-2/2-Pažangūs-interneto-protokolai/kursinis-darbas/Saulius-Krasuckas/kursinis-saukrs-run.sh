#!/bin/bash

echo "$0: Startuoju, cmd-line: "$*

FNAME_PREFIX="saukrs-bandomasis"

DELAY="2"
ns kursinis-saukrs.tcl -- $DELAY"ms" 0.00 "${FNAME_PREFIX}_HSTCP_+_BIC,_${DELAY}ms_0%-loss"
echo
ns kursinis-saukrs.tcl -- 4ms 0.00 $FNAME_PREFIX"_HSTCP_+_BIC,_4ms_0%-loss"
echo

ls -l *.{tr,nam}
echo "Trinam?"; read
rm -v *.{tr,nam}
