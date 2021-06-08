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

# Sukuriame reikiamas ryšio linijas:
$ns duplex-link $node_siustuvas_1 $node_parinktuvas 2Mb 10ms DropTail
$ns duplex-link $node_siustuvas_2 $node_parinktuvas 2Mb 10ms DropTail
$ns duplex-link $node_parinktuvas $node_imtuvas 1.7Mb 20ms DropTail
