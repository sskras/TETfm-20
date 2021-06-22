#!/bin/bash

shopt -s lastpipe

DIR=$(builtin cd $(dirname $0)"/.."; pwd)
FILE_PREFIX="kursinis-saukrs"

LOSS_P="5" #%
echo "$LOSS_P / 100" | bc -l | xargs printf "%.2f" | read LOSS

# Vėlinimas pagal kursinio darbo užduotį, ms:
for DELAY in 2 6 80; do
    # $ftp1 veikia steke su CC-HSTCP algoritmu
    # $ftp2 veikia steke su CC-BIC algoritmu
    ns $DIR/Saulius-Krasuckas/kursinis-saukrs.tcl -- "${DELAY}ms" ${LOSS} ${FILE_PREFIX} \
        0.1 '$ftp1 start' \
        0.2 '$ftp2 start' \
        290 '$ftp1 stop'  \
        290 '$ftp2 stop'  \
        300 'finish'
    echo
    cat ${FILE_PREFIX}.tr | grep '^r .* 2 3' | awk -f $DIR/tools/NS-2/Throughput.awk 2>&1 \
      1>${FILE_PREFIX}-${DELAY}ms-${LOSS_P}%.throughput
done

ls -l *.{tr,nam,throughput}
echo "Trinam?"; read
rm -v *.{tr,nam,throughput}
