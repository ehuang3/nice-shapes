// Actually SFTP uses SSH protocol ports
elementclass SFTPClassifier {
   input -> MarkIPHeader(14)
         -> ip :: IPClassifier(dst tcp port 22, src tcp port 22, -);
   ip[0] -> [0]output
   ip[1] -> [1]output 
   ip[2] -> [2]output
}

FromDevice(eth1)
   -> sftp_cl :: SFTPClassifier;

sftp_cl[0]
   -> IPPrint("SFTP dst 22")
   -> ToHost;

sftp_cl[1]
   -> IPPrint("SFTP src 22")
   -> ToHost;

sftp_cl[2]
   -> ToHost;
