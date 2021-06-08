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

# Sukuriame reikiamas ryšio linijas pagal pvz.:
$ns duplex-link $node_siustuvas_1 $node_parinktuvas 2Mb 10ms DropTail
$ns duplex-link $node_siustuvas_2 $node_parinktuvas 2Mb 10ms DropTail
$ns duplex-link $node_parinktuvas $node_imtuvas 1.7Mb 20ms DropTail

# Tiriamai linijai nustatome Queue Size pagal pvz.:
$ns queue-limit $node_parinktuvas $node_imtuvas 10

# Tegul siustuvas_1 turi vieną TCP srauto šaltinį:
set tcp_source_1 [new Agent/TCP]

# Priskiriame jam Flow-id ir klasę:
$tcp_source_1 set fid_ 1
$tcp_source_1 set class_ 2

# Prijungiame srauto šaltinį prie siustuvo_1:
$ns attach-agent $node_siustuvas_1 $tcp_source_1

# Tegul imtuvas priima irgi TCP transportu:
set tcp_destination [new Agent/TCPSink]
$ns attach-agent $node_imtuvas $tcp_destination

# Sujungiame TCP agentus tarp "siustuvas_1" ir "imtuvas":
$ns connect $tcp_source_1 $tcp_destination

# Prisegame FTP užpildą (Payload) prie pirmojo TCP srauto šaltinio:
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp_source_1
$ftp1 set type_ FTP

# Tegul siustuvas_2 turi vieną UDP srauto šaltinį:
set udp_source_2 [new Agent/UDP]

# Priskiriame jam Flow-id:
$udp_source_2 set fid_ 2
