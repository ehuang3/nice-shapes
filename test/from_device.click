FromDevice(wlan1)
   -> dt :: Tee(2)

   // USERMODE
   // -> Discard; 

   // KERNELMODE
   -> ToHost; 

dt[1]
   -> Strip(14)
   -> CheckIPHeader(0, CHECKSUM true)
   -> IPPrint(wlan1)
   -> Discard;
