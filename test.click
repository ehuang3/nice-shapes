
// Our main pipe
//RatedSource(LENGTH 1500, BANDWIDTH 1500000, LIMIT 100, STOP yes)

//require(unibo_qos);

//FromDevice(eth0)
//	-> BandwidthMeter(125kbps)
//	-> Strip(14)
//	-> CheckIPHeader
//	-> pro :: IPClassifier(tcp, udp, -);


elementclass SplitByRate {
rates :: BandwidthMeter(125kbps);
	input -> rates
	rates[0] -> output
	rates[0] -> FastShaper -> output
}

elementclass Shaper {
	input 
	-> BandwidthShaper(125kbps)
	-> output
}

fromDevice(eth0) -> SplitByRate;
SplitByRate[0] -> ToDevice;
SplitByRate[1] -> Shaper -> Discard // for now

// TCP
//pro[0] -> portTCP :: IPClassifier(src tcp port 6346 or 4662 or 6699 or 6881 or 6889, -);

//portTCP[0] -> Queue -> Shaper(2) -> Unqueue -> IPPrint -> Discard;
//portTCP[1] -> Discard;

// UDP
//pro[1] -> portUDP :: IPClassifier(src udp port 6346 or 6347 or 4672 or 6881 or 6889, -);

//portUDP[0] -> Queue -> Shaper(2) -> Unqueue -> IPPrint -> Discard;
//portUDP[1] -> r :: RTPClassifier -> Discard;

//r[1] -> Discard;

// Rest
//pro[3] -> Discard;


