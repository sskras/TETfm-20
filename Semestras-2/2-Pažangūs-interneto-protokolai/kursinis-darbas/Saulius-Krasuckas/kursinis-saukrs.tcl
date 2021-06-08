# Susidėliokim simuliatorių:
set ns [new Simulator]

# Generuosime TR-formato treisus:
set nf [open kursinis-saukrs.tr w]
$ns trace-all $nf

# Prireiks uždarymo procedūros:
proc finish {} {
    # pasiimam pora globalių kintamųjų:
    global ns nf
    # išsaugom treiso likučius į failą:
    $ns flush-trace
    # uždarom treisą:
    close $nf
    # startuojam vizualizaciją
    # TODO ateičiai
    exit 0
}

# Kuriame nodus (pagal sample.tcl pradžiai):
set node_siustuvas_1   [$ns node]
set node_siustuvas_2   [$ns node]
set node_parinktuvas   [$ns node]
set node_imtuvas       [$ns node]
