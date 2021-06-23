#!/bin/bash

shopt -s lastpipe

DIR=$(builtin cd $(dirname $0)"/.."; pwd)
FILE_PREFIX="kursinis-saukrs"
SCRIPT_NS2="$DIR/Saulius-Krasuckas/kursinis-saukrs.tcl"
SCRIPT_PLT="$DIR/Saulius-Krasuckas/kursinis-saukrs-throughput-by-delay.p"
SCRIPT_THR="$DIR/tools/NS-3/Throughput.awk"
TMP_TRACEFILE="${FILE_PREFIX}.tr"
LOG_S="${FILE_PREFIX}.log"
OUT1="${FILE_PREFIX}-0%.throughput-by-time.png"

# Išvalome logą:
> ${LOG_S}

xthr () # eXtract THRoughput: funkcija ištraukia pralaidumą tiriamojoje linijoje tarp Node 2 ir Node 3 (parinktuvų)
{
    cat ${TMP_TRACEFILE} | grep '^r .* 2 3' | awk -f ${SCRIPT_THR} 2>&1 1>${1}
}

# $ftp1 veikia steke su CC-algoritmu HSTCP
# $ftp2 veikia steke su CC-algoritmu BIC

read -r -d '' RUN_HSTCP_AND_BIC << \
----------------------
    0.1 '\$ftp1 start'
    0.1 '\$ftp2 start'
    2.8 '\$ftp1 stop'
    2.8 '\$ftp2 stop'
    3.0 'finish'
----------------------

# Dubliuoju išvestį į logą:
exec > >(tee -i ${LOG_S}) 2>&1

# Keičiu vėlinimą pagal kursinio darbo užduotį:
TH1a=${FILE_PREFIX}--2ms-0%.thr; eval ns ${SCRIPT_NS2} --  "2ms" 0.00 ${TMP_TRACEFILE} ${RUN_HSTCP_AND_BIC}; xthr ${TH1a}
TH1b=${FILE_PREFIX}--6ms-0%.thr; eval ns ${SCRIPT_NS2} --  "6ms" 0.00 ${TMP_TRACEFILE} ${RUN_HSTCP_AND_BIC}; xthr ${TH1b}
TH1c=${FILE_PREFIX}-80ms-0%.thr; eval ns ${SCRIPT_NS2} -- "80ms" 0.00 ${TMP_TRACEFILE} ${RUN_HSTCP_AND_BIC}; xthr ${TH1c}

# Stabdau išvesties dubliavimą į logą:
exec > /dev/tty 2>&1

gnuplot -e 'out1="'${OUT1}'"' ${SCRIPT_PLT}                     # Braižome pirmą diagramą
gio open ${OUT1}                                                # Atidarome pirmą diagramą
rm -v ${TMP_TRACEFILE}*                                         # Ištriname tarpinius (Trace-) failus:
ls -l ${FILE_PREFIX}*                                           # Parodome sukurtus failus:
