#!/bin/bash

shopt -s lastpipe

DIR=$(builtin cd $(dirname $0)"/.."; pwd)
FILE_PREFIX="kursinis-saukrs"
SCRIPT_TCL="$DIR/Saulius-Krasuckas/kursinis-saukrs.tcl"
SCRIPT_GPL="$DIR/Saulius-Krasuckas/kursinis-saukrs-throughput-by-delay.p"
SCRIPT_AWK="$DIR/tools/NS-2/Throughput.awk"
TMP_TRACEFILE="${FILE_PREFIX}.tr"
OUT_SIMUL_LOG="${FILE_PREFIX}.log"
OUT_DIAGRAM_1="${FILE_PREFIX}-0%.throughput-by-time.png"

LOSS_P="0" #%
echo "$LOSS_P / 100" | bc -l | xargs printf "%.2f" | read LOSS

# $ftp1 veikia steke su CC-algoritmu HSTCP
# $ftp2 veikia steke su CC-algoritmu BIC

> ${OUT_SIMUL_LOG}

# Vėlinimas pagal kursinio darbo užduotį, ms:
for DELAY in 2 6 80; do
    ns ${SCRIPT_TCL} -- "${DELAY}ms" ${LOSS} ${FILE_PREFIX} \
        0.1 '$ftp1 start' \
        0.1 '$ftp2 start' \
        2.8 '$ftp1 stop'  \
        2.8 '$ftp2 stop'  \
        3.0 'finish'      |
    tee -a ${OUT_SIMUL_LOG}
    cat ${TMP_TRACEFILE} | grep '^r .* 2 3' | awk -f ${SCRIPT_AWK} 2>&1 \
    2>&1 1>${FILE_PREFIX}-${DELAY}ms-${LOSS_P}%.throughput | \
    tee -a ${OUT_SIMUL_LOG}
done

ls -l ${TMP_TRACEFILE}* ${FILE_PREFIX}*.throughput
rm -v ${TMP_TRACEFILE}*

gnuplot -e 'file_out="'${OUT_DIAGRAM_1}'"' ${SCRIPT_GPL}
gio open ${OUT_DIAGRAM_1}
