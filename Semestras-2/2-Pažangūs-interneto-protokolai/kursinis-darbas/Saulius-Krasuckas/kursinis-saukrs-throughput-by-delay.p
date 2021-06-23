set terminal png size 1024,768
set output "band.png"
set logscale y
set grid x y mx my
plot "kursinis-saukrs-2ms-0%.throughput" using 1:2 with lines, \
     "kursinis-saukrs-6ms-0%.throughput"  using 1:2 with lines, \
     "kursinis-saukrs-80ms-0%.throughput" using 1:2 with p pt 7
