#!/bin/bash

shopt -s lastpipe

DIR=$(builtin cd $(dirname $0)"/.."; pwd)
FILE_PREFIX="kursinis-saukrs"
SCRIPT_NS2="$DIR/Saulius-Krasuckas/kursinis-saukrs.tcl"
SCRIPT_PLT="$DIR/Saulius-Krasuckas/kursinis-saukrs-throughput-by-delay.p"
SCRIPT_THR="$DIR/tools/NS-2/Throughput.awk"
TRCE="${FILE_PREFIX}.tr"
LOGF="${FILE_PREFIX}.log"
OUT1="${FILE_PREFIX}-01-pralaidumas-CWND_MAX=256000-skirtingiems-Cg-algoritmams.2ms+0%.png"
OUT2="${FILE_PREFIX}-02-pralaidumas-CWND_MAX=256000-skirtingiems-vėlinimams.0%.png"
OUT3="${FILE_PREFIX}-03-pralaidumas-CWND_MAX=256000-skirtingiems-praradimams.2ms.png"
OUT4="${FILE_PREFIX}-04-pralaidumas-CWND_MAX=20-skirtingiems-Cg-algoritmams.2ms+0%.png"
OUT5="${FILE_PREFIX}-05-pralaidumas-CWND_MAX=20-skirtingiems-vėlinimams.0%.png"
OUT6="${FILE_PREFIX}-06-pralaidumas-CWND_MAX=20-skirtingiems-praradimams.2ms.png"

# Išvalome logą:
> ${LOGF}

xthr () # eXtract THRoughput: funkcija ištraukia pralaidumą tiriamojoje linijoje tarp Node 2 ir Node 3 (parinktuvų)
{
    cat ${1} | grep '^r .* 2 3' | awk -f ${SCRIPT_THR} 2>&1 1>${2}
}

# $ftp1 veikia steke su CC-algoritmu HSTCP
# $ftp2 veikia steke su CC-algoritmu BIC
#
# Pagal tai ir sudaromi NS-2 tvarkaraščiai:

read -r -d '' RUN_HSTCP_ONLY << \
----------------------
    0.1 '\$ftp1 start'
    298 '\$ftp1 stop'
    300 'finish'
----------------------

read -r -d '' RUN_BIC_ONLY << \
----------------------
    0.1 '\$ftp2 start'
    298 '\$ftp2 stop'
    300 'finish'
----------------------

read -r -d '' RUN_HSTCP_AND_BIC << \
----------------------
    0.1 '\$ftp1 start'
    0.1 '\$ftp2 start'
    298 '\$ftp1 stop'
    298 '\$ftp2 stop'
    300 'finish'
----------------------

exec > >(tee -i ${LOGF}) 2>&1           # Dubliuoju išvestį į logą

# Naudoju skirtingus Cg-valdymus kai vėlinimas ir paketų praradimai yra minimalūs:
TH1a=${FILE_PREFIX}-1a-HSTCP-2ms-0%.thr; eval ns ${SCRIPT_NS2} --  2ms 0.00 ${TRCE} ${RUN_HSTCP_ONLY};    xthr ${TRCE} ${TH1a}
TH1b=${FILE_PREFIX}-1b-BIC---2ms-0%.thr; eval ns ${SCRIPT_NS2} --  2ms 0.00 ${TRCE} ${RUN_BIC_ONLY};      xthr ${TRCE} ${TH1b}

# Keičiu vėlinimą pagal kursinio darbo užduotį:
TH2a=${FILE_PREFIX}-2a-ABU---2ms-0%.thr; eval ns ${SCRIPT_NS2} --  2ms 0.00 ${TRCE} ${RUN_HSTCP_AND_BIC}; xthr ${TRCE} ${TH2a}
TH2b=${FILE_PREFIX}-2b-ABU---6ms-0%.thr; eval ns ${SCRIPT_NS2} --  6ms 0.00 ${TRCE} ${RUN_HSTCP_AND_BIC}; xthr ${TRCE} ${TH2b}
TH2c=${FILE_PREFIX}-2c-ABU--80ms-0%.thr; eval ns ${SCRIPT_NS2} -- 80ms 0.00 ${TRCE} ${RUN_HSTCP_AND_BIC}; xthr ${TRCE} ${TH2c}

# Keičiu paketų praradimą pagal kursinio darbo užduotį:
TH3a=${FILE_PREFIX}-3a-ABU---2ms-1%.thr; eval ns ${SCRIPT_NS2} --  2ms 0.01 ${TRCE} ${RUN_HSTCP_AND_BIC}; xthr ${TRCE} ${TH3a}
TH3b=${FILE_PREFIX}-3b-ABU---2ms-4%.thr; eval ns ${SCRIPT_NS2} --  2ms 0.04 ${TRCE} ${RUN_HSTCP_AND_BIC}; xthr ${TRCE} ${TH3b}
TH3c=${FILE_PREFIX}-3c-ABU---2ms-6%.thr; eval ns ${SCRIPT_NS2} --  2ms 0.06 ${TRCE} ${RUN_HSTCP_AND_BIC}; xthr ${TRCE} ${TH3c}

exec > /dev/tty 2>&1                    # Stabdau išvesties dubliavimą

gnuplot -e                                    \
'in1="'${TH2a}'"; tt1="Highspeed-TCP + BIC"; '\
'in2="'${TH1a}'"; tt2="Tik Highspeed-TCP";   '\
'in3="'${TH1b}'"; tt3="Tik BIC";             '\
'out="'${OUT4}'"; pav="Pralaidumas panaudojus tik HSTCP, tik BIC ir abu Cg-valdymo algoritmus kartu, kai vėlinimas = 2 ms, praradimas = 0%"' \
       ${SCRIPT_PLT}                    # Braižome pirmą diagramą

gnuplot -e                                 \
'in1="'${TH2a}'"; tt1="Vėlinimas:  2 ms"; '\
'in2="'${TH2b}'"; tt2="Vėlinimas:  6 ms"; '\
'in3="'${TH2c}'"; tt3="Vėlinimas: 80 ms"; '\
'out="'${OUT5}'"; pav="Pralaidumas panaudojus HSTCP+BIC, kai paketų praradimas = 0%"' \
       ${SCRIPT_PLT}                    # Braižome antrą diagramą

gnuplot -e                                       \
'in1="'${TH3a}'"; tt1="Paketų praradimas:  1%"; '\
'in2="'${TH3b}'"; tt2="Paketų praradimas:  4%"; '\
'in3="'${TH3c}'"; tt3="Paketų praradimas:  6%"; '\
'out="'${OUT6}'"; pav="Pralaidumas panaudojus HSTCP+BIC, kai paketų vėlinimas = 2 ms"' \
       ${SCRIPT_PLT}                    # Braižome trečią diagramą

gio open ${OUT4}                        # Atidarome pirmą diagramą
gio open ${OUT5}                        # Atidarome antrą diagramą
gio open ${OUT6}                        # Atidarome trečią diagramą

rm -v ${TRCE}*                          # Ištriname tarpinius Trace-failus
ls -l ${FILE_PREFIX}*                   # Parodome sukurtus failus

# XXX: Jeigu įjungiu STDOUT redirektinimą, NS-2 komanda "select_ca highspeed" pranešimus
#      į STDOUT išveda su geroku vėlinimu, pačioje simuliacijos pabaigoje, jau po "finish {}":
#   ...
# Linijos vėlinimas: 2ms
# Paketų praradimas: 0.00
# Congestion Window lubos: 256000
# MSS: 1448
# Tvarkaraštis: 0.1, $ftp1 start
# Tvarkaraštis: 2.8, $ftp1 stop
# Tvarkaraštis: 3.0, finish
# Simuliacijos pradžia...
# Simuliacijos pabaiga.
# cmd select_ca highspeed         <
# cmd select_ca bic               <
#
#      Jei STDOUT lieka be redirekto, šie pranešimai išvedami daug anksčiau, prieš simuliaciją:
#  ...
# Linijos vėlinimas: 2ms
# Paketų praradimas: 0.00
# Congestion Window lubos: 256000
# MSS: 1448
# cmd select_ca highspeed         <
# cmd select_ca bic               <
# Tvarkaraštis: 0.1, $ftp1 start
# Tvarkaraštis: 2.8, $ftp1 stop
# Tvarkaraštis: 3.0, finish
# Simuliacijos pradžia...
# Simuliacijos pabaiga.
#
# Turbūt smulkus NS-2 bugas.
# TODO: patikrinti su NS-3 (jei sintaksė ta pati)
