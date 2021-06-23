set terminal png size 1024,384
set output file_out

set xlabel "Laikas, s"
set ylabel "Pralaidumas, Mbps"
set format y "%.0f"
set mxtics 5
set grid x y mx my

set key below right maxcols 1
set title "Pralaidumo kitimas laike naudojant HSTCP+BIC, kai paketų praradimas = 0%"

plot "kursinis-saukrs-2ms-0%.throughput"  using 1:($2/1000000) with lines title 'Vėlinimas: 2 ms', \
     "kursinis-saukrs-6ms-0%.throughput"  using 1:($2/1000000) with lines title "Vėlinimas: 6 ms", \
     "kursinis-saukrs-80ms-0%.throughput" using 1:($2/1000000) with lines title "Vėlinimas: 80 ms"
