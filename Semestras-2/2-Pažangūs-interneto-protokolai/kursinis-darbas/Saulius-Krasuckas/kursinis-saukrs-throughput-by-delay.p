set terminal png size 1024,384
set output "band.png"

set xlabel "Laikas, s"
set ylabel "Pralaidumas, Mbps"
set format y "%.0f"
set grid x y mx my

plot "kursinis-saukrs-2ms-0%.throughput"  using 1:($2/1000000) with lines, \
     "kursinis-saukrs-6ms-0%.throughput"  using 1:($2/1000000) with lines, \
     "kursinis-saukrs-80ms-0%.throughput" using 1:($2/1000000) with lines
