# Susidėliokim simuliatorių:
set ns [new Simulator]

# Generuosime TR-formato treisus:
set ntf [open kursinis-saukrs.tr w]
$ns trace-all $ntf

# Generuosime NAM-formato treisus:
set nmf [open kursinis-saukrs.nam w]
$ns namtrace-all $nmf

# Prireiks uždarymo procedūros:
proc finish {} {
    puts "Simuliacijos pabaiga."
    global ns ntf nmf               ; # pasiimam pora globalių kintamųjų
    $ns flush-trace                 ; # išsaugom treiso likučius į failą
    close $ntf                      ; # uždarom treisą
    close $nmf                      ; # uždarom NAM-treisą
    exec nam kursinis-saukrs.nam &  ; # startuojam vizualizaciją
    exit 0
}

# Kuriame nodus (pagal sample.tcl pradžiai):
set node_siustuvas_1   [$ns node]   ; # 0
set node_siustuvas_2   [$ns node]   ; # 1
set node_parinktuvas   [$ns node]   ; # TODO
set node_parinktuvas_2 [$ns node]   ; # TODO
set node_imtuvas       [$ns node]   ; # TODO

# Tiriamojo tinklo parametrai:
set SPARTA 100Mb
set VELINIMAS [lindex $argv 1]      ; # iš komandinės eilutės (pirmas argumentas)
puts "Kanalų sparta: $SPARTA"
puts "Linijos vėlinimas: $VELINIMAS"

# Sukuriame reikiamas ryšio linijas pagal pvz.:
$ns duplex-link $node_siustuvas_1 $node_parinktuvas   $SPARTA 1ms        DropTail
$ns duplex-link $node_siustuvas_2 $node_parinktuvas   $SPARTA 1ms        DropTail
$ns duplex-link $node_parinktuvas $node_parinktuvas_2 $SPARTA $VELINIMAS DropTail   ; # Tiriamoji linija
$ns duplex-link $node_parinktuvas_2 $node_imtuvas     $SPARTA 1ms        DropTail

# Tiriamai linijai nustatome Queue Size pagal pvz.:
$ns queue-limit $node_parinktuvas $node_parinktuvas_2 10

# Sukuriame pirmą TCP srauto šaltinį:
set tcp_source_1 [new Agent/TCP]
$tcp_source_1 set class_ 2              ; # BUG: jei "fid_" priskiriame prieš "class_", Trace-faile Flow-id tampa = 2
$tcp_source_1 set fid_ 1                ; # Flow-id
$node_siustuvas_1 attach $tcp_source_1  ; # Prijungiame prie siustuvo

# Sukuriame antrą TCP srauto šaltinį:
set tcp_source_2 [new Agent/TCP]
$tcp_source_2 set class_ 2
$tcp_source_2 set fid_ 2
$node_siustuvas_2 attach $tcp_source_2  ; # Prijungiame prie siustuvo

# Sukuriame vieną TCP srauto imtuvą:
set tcp_destination [new Agent/TCPSink]
$node_imtuvas attach $tcp_destination   ; # Prijungiame prie imtuvo nodo

# Sukuriame antrą TCP srauto imtuvą:
set tcp_destination_2 [new Agent/TCPSink]
$node_imtuvas attach $tcp_destination_2 ; # Prijungiame prie imtuvo nodo

# Sujungiame TCP agentus tarp "siustuvas_1" ir "imtuvas":
$ns connect $tcp_source_1 $tcp_destination
$ns connect $tcp_source_2 $tcp_destination_2

# Sukuriame pirmą FTP užpildą (Payload):
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp_source_1        ; # Prisegame prie TCP šaltinio
$ftp1 set type_ FTP

# Sukuriame antrą FTP užpildą (Payload):
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp_source_2        ; # Prisegame prie TCP šaltinio
$ftp2 set type_ FTP

# Sudarome tinklo įvykių grafiką (vėlgi pagal pvz.):
$ns at 0.1 "$ftp1 start"
$ns at 0.2 "$ftp2 start"
$ns at 4.0 "$ftp1 stop"
$ns at 4.9 "$ftp2 stop"

# Įvykdome uždarymo procedūrą praėjus 5s simuliacijos laiko:
$ns at 5.0 "finish"

# Tinklo topologiją žymime grafiškai:
$ns duplex-link-op $node_siustuvas_1 $node_parinktuvas orient down
$ns duplex-link-op $node_siustuvas_2 $node_parinktuvas orient right-up
$ns duplex-link-op $node_parinktuvas   $node_parinktuvas_2 orient right
$ns duplex-link-op $node_parinktuvas_2 $node_imtuvas       orient right

# Skirtingos spalvos skirtingiems Flow-id:
$ns color 1 Blue
$ns color 2 Red

puts "Simuliacijos pradžia..."

# Pradedame:
$ns run
