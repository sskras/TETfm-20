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

# Išvalome logą:
> ${OUT_SIMUL_LOG}

# $ftp1 veikia steke su CC-algoritmu HSTCP
# $ftp2 veikia steke su CC-algoritmu BIC

xthr () # eXtract THRoughput: funkcija ištraukia pralaidumą tiriamojoje linijoje tarp Node 2 ir Node 3 (parinktuvų)
{
    cat ${TMP_TRACEFILE} | grep '^r .* 2 3' | awk -f ${SCRIPT_AWK} 2>&1 1>${1}
}

read -r -d '' RUN_HSTCP_AND_BIC << \
-------------------------
    0.1 '\$ftp1 start'
    0.1 '\$ftp2 start'
    2.8 '\$ftp1 stop'
    2.8 '\$ftp2 stop'
    3.0 'finish'
-------------------------
echo $CMD2

# Vėlinimas pagal kursinio darbo užduotį, ms:
for DELAY in 2 6 80; do
(eval ns ${SCRIPT_TCL} --  "2ms" 0.00 ${TMP_TRACEFILE} ${RUN_HSTCP_AND_BIC}; xthr ${FILE_PREFIX}--2ms-0%.throughput) | tee -a ${OUT_SIMUL_LOG}
done

gnuplot -e 'file_out="'${OUT_DIAGRAM_1}'"' ${SCRIPT_GPL}        # Braižome pirmą diagramą
gio open ${OUT_DIAGRAM_1}                                       # Atidarome pirmą diagramą:
rm -v ${TMP_TRACEFILE}*                                         # Ištriname tarpinius (Trace-) failus:
ls -l ${FILE_PREFIX}*                                           # Parodome sukurtus failus:
