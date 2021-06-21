# Tiriamojo tinklo parametrai:
set SPARTA 100Mb
set QDEPTH 10                       ; # Queue Size paketais (pagal simple.tcl pvz.)
set VELINIMAS [lindex $argv 1]      ; # iš komandinės eilutės (pirmas argumentas)
set PRARADIMAS [lindex $argv 2]     ; # iš komandinės eilutės (antras argumentas)
set WND_SIZE 256000                 ; # maksimalus Congestion Window dydis
set MSS 1448                        ; # Maximum Segment Size
set TRUKME 500                      ; # modeliavimo trukmė, s
set PRADZIA 0.1                     ; # visų siųstuvų starto laikas, s
set STABDIS 490                     ; # visų siųstuvų stabdymo laikas, s

# Pavadinimai:
set SESSION_NAME [lindex $argv 3]   ; # iš komandinės eilutės (trečias argumentas, nebūtinas)

if {$SESSION_NAME == ""} {
    set SESSION_NAME "kursinis-saukrs"
}
set TRACE_NAME "$SESSION_NAME.tr"
set NAM_NAME   "$SESSION_NAME.nam"

# Siųstuvų paleidimai:
puts "\$argc = $argc"

for {set i 4} {$i < $argc} {incr i} {
    set PRADEDAM [lindex $argv $i]
    lappend STARTAI $PRADEDAM
}
#puts "Sukaupti \$STARTAI: $STARTAI"

puts "=================================="
puts "Kanalų sparta: $SPARTA"
puts "Parinktuvų buferių gylis: $QDEPTH"
puts "Linijos vėlinimas: $VELINIMAS"
puts "Paketų praradimas: $PRARADIMAS"
puts "Congestion Window lubos: $WND_SIZE"
puts "MSS: $MSS"
puts " TR-failas: '$TRACE_NAME'"
puts "NAM-failas: '$NAM_NAME'"
puts "=================================="

# Susidėliokim simuliatorių:
set ns [new Simulator]

# Generuosime TR-formato treisus:
set ntf [open $TRACE_NAME w]
$ns trace-all $ntf

# Generuosime NAM-formato treisus:
set nmf [open $NAM_NAME w]
# kurį laiką negeneruosime:
#$ns namtrace-all $nmf

# Prireiks uždarymo procedūros:
proc finish {} {
    puts "Simuliacijos pabaiga."
    global ns ntf nmf               ; # pasiimam pora globalių kintamųjų
    $ns flush-trace                 ; # išsaugom treiso likučius į failą
    close $ntf                      ; # uždarom treisą
    close $nmf                      ; # uždarom NAM-treisą
#   exec nam kursinis-saukrs.nam &  ; # startuojam vizualizaciją
    exit 0
}

# Kuriame nodus (pagal sample.tcl pradžiai):
set node_siustuvas_1   [$ns node]   ; # 0
set node_siustuvas_2   [$ns node]   ; # 1
set node_parinktuvas   [$ns node]   ; # TODO
set node_parinktuvas_2 [$ns node]   ; # TODO
set node_imtuvas       [$ns node]   ; # TODO

# Įjungiame praradimų mechanizmą:
set NUOSTOLIAI [new ErrorModel]
$NUOSTOLIAI set rate_ $PRARADIMAS               ; # Error rate: vieneto dalys
$NUOSTOLIAI unit pkt                            ; # Error unit: paketai (Default)
$NUOSTOLIAI ranvar [new RandomVariable/Uniform] ; # Random variable: turbūt (0; 1), pagal tolygios tikimybės skirstinį
$NUOSTOLIAI drop-target [new Agent/Null]        ; # Target for dropped packets

# Sukuriame reikiamas ryšio linijas pagal pvz.:
$ns duplex-link $node_siustuvas_1 $node_parinktuvas   $SPARTA 1ms        DropTail
$ns duplex-link $node_siustuvas_2 $node_parinktuvas   $SPARTA 1ms        DropTail
$ns duplex-link $node_parinktuvas $node_parinktuvas_2 $SPARTA $VELINIMAS DropTail   ; # Tiriamoji linija
$ns duplex-link $node_parinktuvas_2 $node_imtuvas     $SPARTA 1ms        DropTail

# Tiriamajai linijai:
$ns queue-limit $node_parinktuvas $node_parinktuvas_2 $QDEPTH       ; # nurodome Queue Size
$ns lossmodel $NUOSTOLIAI $node_parinktuvas $node_parinktuvas_2     ; # prijungiame praradimų mechanizmą

# Sukuriame pirmą TCP srauto šaltinį:
set tcp_source_1 [new Agent/TCP/Linux]
$tcp_source_1 set class_ 2              ; # BUG: jei "fid_" priskiriame prieš "class_", Trace-faile Flow-id tampa = 2
$tcp_source_1 set fid_ 1                ; # Flow-id
$tcp_source_1 set window_ $WND_SIZE     ; # Congestion Window lubos
$tcp_source_1 set packetSize_ $MSS      ; # Maximum Segment Size
$tcp_source_1 select_ca highspeed       ; # Congestion-control algoritmas = Highspeed-TCP (hstcp)
$node_siustuvas_1 attach $tcp_source_1  ; # Prijungiame prie siųstuvo #1

# Sukuriame antrą TCP srauto šaltinį:
set tcp_source_2 [new Agent/TCP/Linux]
$tcp_source_2 set class_ 2
$tcp_source_2 set fid_ 2
$tcp_source_2 set window_ $WND_SIZE
$tcp_source_2 set packetSize_ $MSS
$tcp_source_2 select_ca bic             ; # Congestion-control algoritmas = TCP BIC
$node_siustuvas_2 attach $tcp_source_2  ; # Prijungiame prie siųstuvo #2

# Sukuriame vieną TCP srauto gavėją:
set tcp_destination_1 [new Agent/TCPSink]
$node_imtuvas attach $tcp_destination_1 ; # Prijungiame prie imtuvo

# Sukuriame antrą TCP srauto gavėją:
set tcp_destination_2 [new Agent/TCPSink]
$node_imtuvas attach $tcp_destination_2 ; # Prijungiame prie imtuvo

# Sujungiame TCP agentus tarp "siustuvas_1" ir "imtuvas":
$ns connect $tcp_source_1 $tcp_destination_1
$ns connect $tcp_source_2 $tcp_destination_2

# Sukuriame pirmą FTP užpildą (Payload):
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp_source_1        ; # Prisegame prie TCP šaltinio
$ftp1 set type_ FTP

# Sukuriame antrą FTP užpildą (Payload):
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp_source_2        ; # Prisegame prie TCP šaltinio
$ftp2 set type_ FTP

# Siųstuvų įvykiai:
foreach {KADA KURIS} $STARTAI {
    puts "Tvarkaraštis: $KADA, $KURIS"
    $ns at $KADA $KURIS
}

# Sudarome tinklo įvykių grafiką (vėlgi pagal pvz.):
#$ns at $PRADZIA "$ftp1 start"
#$ns at $PRADZIA "$ftp2 start"
$ns at $STABDIS "$ftp1 stop"
$ns at $STABDIS "$ftp2 stop"

# Įvykdome uždarymo procedūrą praėjus 5s simuliacijos laiko:
$ns at $TRUKME "finish"

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
