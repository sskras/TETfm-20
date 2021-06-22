#!/bin/bash

shopt -s lastpipe

DIR=$(builtin cd $(dirname $0)"/.."; pwd)
FILE_PREFIX="kursinis-saukrs"

LOSS="0.00"
echo "$LOSS * 100" | bc -q | xargs printf "%d\n" | read LOSS_P

# Vėlinimas pagal kursinio darbo užduotį, ms:
for DELAY in 2 6 80; do
#   ns $DIR/kursinis-saukrs.tcl -- "${DELAY}ms" ${LOSS} "kursinis-saukrs_HSTCP_+_BIC,_${DELAY}ms_${LOSS_P}%-loss" \
    ns $DIR/Saulius-Krasuckas/kursinis-saukrs.tcl -- "${DELAY}ms" ${LOSS} ${FILE_PREFIX} \
        0.1 '$ftp1 start' \
        0.2 '$ftp2 start' \
        2.0 '$ftp1 stop'  \
        2.0 '$ftp2 stop'  \
        3.0 'finish'
    echo
    cat ${FILE_PREFIX}.tr | grep '^r .* 2 3' | awk -f $DIR/tools/NS-2/Throughput.awk 2>&1 1>${FILE_PREFIX}-${DELAY}ms.throughput
done

ls -l *.{tr,nam,throughput}
echo "Trinam?"; read
rm -v *.{tr,nam,throughput}
