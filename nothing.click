FromDevice(wlan1)
   -> Strip(14)
   -> Align(4, 0)    // in case we're not on x86
	-> CheckIPHeader2
   -> IPPrint(BEFORE)
   -> MyNothingElement
   -> IPPrint(MNE)
   -> Discard;
