AddressInfo(real_interface 192.168.137.141 00:0c:29:43:f4:a4);

arpQ :: ARPQuerier(real_interface);

elementclass ftpShaper {
	input -> Queue -> Shaper(2) -> Unqueue
	-> output
}

elementclass ClassifyFTP {
	ftp :: IPClassifier(dst tcp port 22, src tcp port 22, -);
	input -> ftp
	ftp[0] -> IPPrint(FTP_To) -> [0]output // to ftp server
	ftp[1] -> Queue -> Shaper(5) -> Unqueue -> IPPrint(FTP_From) -> [1]output // from ftp server
	ftp[2] -> [2]output	
}



FromDevice(eth0)
	-> Strip(14)
	-> CheckIPHeader(0, CHECKSUM true)
	-> ftp_cl :: ClassifyFTP
	-> ToHost;

ftp_cl[1] -> ToHost;
ftp_cl[2] -> ToHost;