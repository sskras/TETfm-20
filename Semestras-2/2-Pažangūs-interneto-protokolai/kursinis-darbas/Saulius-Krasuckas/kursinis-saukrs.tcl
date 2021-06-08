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
