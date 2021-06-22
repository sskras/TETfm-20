# Sample output:
#
#    $ cat out.tr | grep '^r .* 2 3' | awk -f Throughput.awk
#    0.24s: 1.08 Mbps
#    0.35s: 1.00 Mbps
#    0.45s: 1.00 Mbps
#    0.55s: 1.00 Mbps
#    0.66s: 1.00 Mbps
#    0.76s: 1.00 Mbps
#    0.87s: 1.00 Mbps
#    0.97s: 1.00 Mbps
#    1.07s: 1.00 Mbps
#    1.18s: 1.20 Mbps
#    1.28s: 1.53 Mbps
#    1.38s: 1.70 Mbps
#    1.48s: 1.70 Mbps
#    1.58s: 1.70 Mbps
#    1.68s: 1.28 Mbps
#    1.79s: 1.53 Mbps
#    1.89s: 1.70 Mbps
#    1.99s: 1.70 Mbps
#    2.09s: 1.70 Mbps
#    2.19s: 1.70 Mbps
#    2.29s: 1.70 Mbps
#    2.39s: 1.34 Mbps
#    2.50s: 1.53 Mbps
#    2.60s: 1.61 Mbps
#    2.70s: 1.70 Mbps
#    2.80s: 1.70 Mbps
#    2.90s: 1.70 Mbps
#    3.00s: 1.70 Mbps
#    3.10s: 1.70 Mbps
#    3.20s: 1.70 Mbps
#    3.31s: 1.58 Mbps
#    3.41s: 1.32 Mbps
#    3.51s: 1.61 Mbps
#    3.61s: 1.70 Mbps
#    3.71s: 1.70 Mbps
#    3.81s: 1.70 Mbps
#    3.91s: 1.70 Mbps
#    4.01s: 1.70 Mbps
#    4.12s: 1.70 Mbps
#    4.23s: 1.12 Mbps
#    4.33s: 1.00 Mbps
#    4.43s: 1.00 Mbps

BEGIN {
	recv = 0
	recv_total = 0
	currTime = prevTime = 0
	tic = 0.1
}

{
    # Skip empty lines
    if (NF < 6 || $6 == 0) next

	# Trace line format: normal
	if ($2 != "-t") {
		event = $1
		time = $2
		pkt_size = $6
	}

	# Init prevTime to the first packet recv time
	if (prevTime == 0)
    {
		prevTime = time
        start_time = time
    }

	# # calculating throughput per time interval tic
	if ( event == "r" ) {
		# adding received packet sizes
		recv += pkt_size
		recv_total += pkt_size
		currTime += (time - prevTime)
		# if time value is bigger then tic calculate throughput ant print it
		if (currTime >= tic) {
#			printf("%.2f s: %2.2f Mbps\n", time, (recv/currTime)*8/1000000)
			recv = 0
			currTime = 0
		}
		prevTime = time
	}
}

END {
    duration = prevTime - start_time
    if (duration == 0) exit
    print sprintf("Total data transmitted: %d Bytes", recv_total)                   > "/dev/stderr"
    print sprintf("Transmission duration: %f seconds", duration)                    > "/dev/stderr"
    print sprintf("Average throughput: %f Mbps\n", (recv_total/duration*8/1000000)) > "/dev/stderr"
}
