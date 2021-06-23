set terminal png size 1024,768
set output "band.png"
plot "kursinis-saukrs-2ms-0%.throughput" using 1:2 with lines, \
     "kursinis-saukrs-6ms-0%.throughput" using 1:2 with lines
