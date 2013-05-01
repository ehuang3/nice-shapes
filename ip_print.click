elementclass ClassifyFTP {
	ftp :: IPClassifier(dst tcp port 21, src tcp port 20, -);
	input -> ftp;
	ftp[0] -> IPPrint(FTP_To) -> [0]output // to ftp server
	ftp[1] -> IPPrint(FTP_From) -> [1]output // from ftp server
	ftp[2] -> [2]output	
}

FromDevice(eth0)
	-> Strip(14)
	-> CheckIPHeader(0, CHECKSUM true)
	-> ftp_cl :: ClassifyFTP
	-> Discard;

ftp_cl[1] -> Discard;
ftp_cl[2] -> Discard;