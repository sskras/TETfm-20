set terminal png size 1024,384
set output out

set xlabel "Laikas, s"
set ylabel "Pralaidumas, Mbps"
set format y "%.0f"
set mxtics 5
set grid x y mx my

set key below right maxcols 1
set title pav

plot in1 using 1:($2/1000000) with lines title tt1, \
     in2 using 1:($2/1000000) with lines title tt2, \
     in3 using 1:($2/1000000) with lines title tt3
