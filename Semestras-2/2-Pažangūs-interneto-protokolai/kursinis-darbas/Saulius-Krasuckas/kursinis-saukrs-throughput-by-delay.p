set terminal png size 1024,768
set output "band.png"
plot "kursinis-saukrs-2ms-0%.throughput" with lines, \
     "kursinis-saukrs-2ms-5%.throughput" with errorbars
