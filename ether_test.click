AddressInfo(real_interface 192.168.137.141 00:0c:29:43:f4:a4);

arpQ :: ARPQuerier(real_interface);

from_cl :: Classifier(12/0806 20/0002, // ARP response
                      12/0800); 	// IP packets

FromDevice(eth0)
	-> from_cl;

from_cl[1]
	-> Print(BEFORE)
	-> Strip(14)
	-> [0]arpQ
	-> Print(AFTER)
	-> ToHost;

from_cl[0]
	-> [1]arpQ[1]
	-> ToHost;
