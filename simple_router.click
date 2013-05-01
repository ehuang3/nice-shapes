FromDevice(eth1) -> ToHost;

FromHost(real0, 0.0.0.0/0, TYPE ETHER)
   -> fromhost_cl :: Classifier(12/0806, 12/0800);

fromhost_cl[0] -> ARPResponder(0.0.0.0/0 1-1-1-1-1-1) -> ToHost;
fromhost_cl[1]
   -> IPPrint(real0)
   -> Queue
   -> ToDevice(eth1) // IP packets
