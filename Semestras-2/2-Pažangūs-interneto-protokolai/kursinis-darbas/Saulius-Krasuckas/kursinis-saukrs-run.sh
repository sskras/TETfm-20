#!/bin/bash

shopt -s lastpipe

DIR=$(builtin cd $(dirname $0)"/.."; pwd)
FILE_PREFIX="kursinis-saukrs"
SCRIPT_NS2="$DIR/Saulius-Krasuckas/kursinis-saukrs.tcl"
SCRIPT_PLT="$DIR/Saulius-Krasuckas/kursinis-saukrs-throughput-by-delay.p"
SCRIPT_THR="$DIR/tools/NS-2/Throughput.awk"
TRACE="${FILE_PREFIX}.tr"
LOG_S="${FILE_PREFIX}.log"
OUT2="${FILE_PREFIX}-0%.pralaidumas-skirtingiems-vėlinimams.png"
OUT3="${FILE_PREFIX}-2ms.pralaidumas-skirtingiems-praradimams.png"

# Išvalome logą:
> ${LOG_S}

xthr () # eXtract THRoughput: funkcija ištraukia pralaidumą tiriamojoje linijoje tarp Node 2 ir Node 3 (parinktuvų)
{
    cat ${1} | grep '^r .* 2 3' | awk -f ${SCRIPT_THR} 2>&1 1>${2}
}

# $ftp1 veikia steke su CC-algoritmu HSTCP
# $ftp2 veikia steke su CC-algoritmu BIC

read -r -d '' RUN_HSTCP_AND_BIC << \
----------------------
    0.1 '\$ftp1 start'
    0.1 '\$ftp2 start'
    298 '\$ftp1 stop'
    298 '\$ftp2 stop'
    300 'finish'
----------------------

exec > >(tee -i ${LOG_S}) 2>&1                                  # Dubliuoju išvestį į logą

# Keičiu vėlinimą pagal kursinio darbo užduotį:
TH1a=${FILE_PREFIX}--2ms-0%.thr; eval ns ${SCRIPT_NS2} --  "2ms" 0.00 ${TRACE} ${RUN_HSTCP_AND_BIC}; xthr ${TRACE} ${TH1a}
TH1b=${FILE_PREFIX}--6ms-0%.thr; eval ns ${SCRIPT_NS2} --  "6ms" 0.00 ${TRACE} ${RUN_HSTCP_AND_BIC}; xthr ${TRACE} ${TH1b}
TH1c=${FILE_PREFIX}-80ms-0%.thr; eval ns ${SCRIPT_NS2} -- "80ms" 0.00 ${TRACE} ${RUN_HSTCP_AND_BIC}; xthr ${TRACE} ${TH1c}

# Keičiu paketų praradimą pagal kursinio darbo užduotį:
TH3a=${FILE_PREFIX}--2ms-1%.thr; eval ns ${SCRIPT_NS2} --  "2ms" 0.01 ${TRACE} ${RUN_HSTCP_AND_BIC}; xthr ${TRACE} ${TH3a}
TH3b=${FILE_PREFIX}--2ms-4%.thr; eval ns ${SCRIPT_NS2} --  "2ms" 0.04 ${TRACE} ${RUN_HSTCP_AND_BIC}; xthr ${TRACE} ${TH3b}
TH3c=${FILE_PREFIX}--2ms-6%.thr; eval ns ${SCRIPT_NS2} --  "2ms" 0.06 ${TRACE} ${RUN_HSTCP_AND_BIC}; xthr ${TRACE} ${TH3c}

exec > /dev/tty 2>&1                                            # Stabdau išvesties dubliavimą į logą

gnuplot -e                                 \
'in1="'${TH1a}'"; tt1="Vėlinimas:  2 ms"; '\
'in2="'${TH1b}'"; tt2="Vėlinimas:  6 ms"; '\
'in3="'${TH1c}'"; tt3="Vėlinimas: 80 ms"; '\
'out="'${OUT2}'"; pav="Pralaidumas, sukuriamas panaudojus HSTCP+BIC, kai paketų praradimas = 0%"' \
       ${SCRIPT_PLT}                                            # Braižome pirmą diagramą

gnuplot -e                                       \
'in1="'${TH3a}'"; tt1="Paketų praradimas:  1%"; '\
'in2="'${TH3b}'"; tt2="Paketų praradimas:  4%"; '\
'in3="'${TH3c}'"; tt3="Paketų praradimas:  6%"; '\
'out="'${OUT3}'"; pav="Pralaidumas, sukuriamas panaudojus HSTCP+BIC, kai paketų vėlinimas = 2 ms"' \
       ${SCRIPT_PLT}                                            # Braižome antrą diagramą

gio open ${OUT2}                                                # Atidarome pirmą diagramą
gio open ${OUT3}                                                # Atidarome antrą diagramą

rm -v ${TRACE}*                                                 # Ištriname tarpinius Trace-failus
ls -l ${FILE_PREFIX}*                                           # Parodome sukurtus failus
