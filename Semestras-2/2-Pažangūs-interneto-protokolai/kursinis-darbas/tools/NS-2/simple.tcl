BEGIN {
	recv = 0
	currTime = prevTime = 0
	tic = 0.1
}

{
	# Trace line format: normal
	if ($2 != "-t") {
		event = $1
		time = $2
		pkt_size = $6
	}

	# Init prevTime to the first packet recv time
	if(prevTime == 0)
	{
		prevTime = time
	}

	# # calculating throughput per time interval tic
	if ( event == "r" ) {
		
		# adding received packet sizes
		recv += pkt_size
		currTime += (time - prevTime)
		# if time value is bigger then tic calculate throughput ant print it
		if (currTime >= tic) {
			printf("%.2fs: %2.2f Mbps\n", time, (recv/currTime)*8/1000000)
			recv = 0
			currTime = 0
		}
		prevTime = time
	}
}

END {
	print("")
}
