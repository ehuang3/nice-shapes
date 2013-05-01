FromDevice(wlan1)
   -> Strip(14)
   -> CheckIPHeader(0, CHECKSUM true)
   -> IPPrint(ok)
   -> Discard;
//   -> MyNothingElement
//   -> Discard;

 //FromHost(fake0, 143.215.125.134/32)
 //  //-> MyNothingElement
 //  -> Strip(14)
 //  -> CheckIPHeader(0, CHECKSUM true)
 //  -> IPPrint(ok)
 //  -> Queue(200)
 //  -> Discard;
 //  //-> ToDevice(wlan1);
