
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

 elementclass ClassifyFTP {
	ftp :: IPClassifier(dst tcp port 21, src tcp port 20, -);
	input -> ftp;
	ftp[0] -> Print(FTP_To) -> [0]output // to ftp server
	ftp[1] -> Print(FTP_From) -> [1]output // from ftp server
	ftp[2] -> [2]output	
}


// MAIN
// fromDevice(eth0) -> SplitByRate;
// SplitByRate[0] -> ToDevice;
// SplitByRate[1] -> Shaper -> Discard // for now


FromDevice(eth0) // -> pro :: IPClassifier(tcp, -);
// pro[0] -> Discard
// pro[1] -> Discard


// -> Discard;
//	-> BandwidthMeter(125kbps)
//	-> Strip(14)
//	-> CheckIPHeader
	-> pro :: IPClassifier(tcp, udp, -);
// pro[0]->Discard;
// TCP
 pro[0] -> ftp_cl :: ClassifyFTP;
 ftp_cl[0] -> Discard;
 ftp_cl[1] -> Discard; // ToDevice(eth0);
 ftp_cl[2] -> Discard;

// UDP
 pro[1] -> Discard;

// Rest
 pro[2] -> Discard;


