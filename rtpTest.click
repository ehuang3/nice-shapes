
// Our main pipe
//RatedSource(LENGTH 1500, BANDWIDTH 1500000, LIMIT 100, STOP yes)

//require(unibo_qos);

elementclass SplitByRate {
rates :: BandwidthMeter(125kbps);
	input -> rates
	rates[0] -> output
	rates[1] -> Shaper -> output
}

elementclass Shaper {
	input 
	-> BandwidthShaper(125kbps)
	-> output
}

elementclass ClassifyRTP {
	rtp :: RTPClassifier;
	input -> rtp;
	rtp[0] -> // if rtp on top of tcp, chances are, its youtube packet
	rpt[1] -> Discard; 	
}


// MAIN
// fromDevice(eth0) -> SplitByRate;
// SplitByRate[0] -> ToDevice;
// SplitByRate[1] -> Shaper -> Discard // for now


FromDevice(eth0)
//	-> BandwidthMeter(125kbps)
//	-> Strip(14)
//	-> CheckIPHeader
	-> pro :: IPClassifier(tcp, udp, -);

// TCP
pro[0] -> portTCP :: IPClassifier(src tcp port 6346 or 4662 or 6699 or 6881 or 6889, -);

//portTCP[0] -> BandwidthShaper(125kbps) -> IPPrint -> Discard;
//portTCP[1] -> Discard;

// UDP
//pro[1] -> portUDP :: IPClassifier(src udp port 6346 or 6347 or 4672 or 6881 or 6889, -);

//portUDP[0] -> BandwidthShaper(125kbps) -> IPPrint -> Discard;
//portUDP[1] -> r :: RTPClassifier -> Discard;

//r[1] -> Discard;

// Rest
//pro[3] -> Discard;


