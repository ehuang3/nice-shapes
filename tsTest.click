// initconf.click

// This can be our initial configuration to test our logic.

// NOTE: To read from eth0, you need to run click with root
//       access which requires installing click on root


// our bandwidth measure can perhaps go here
// we probably want to change the structure in the future
// so that OurMeasure and OurShaper and communicate and we
// probably want to use outside tools to measure bandwidth 
elementclass OurMeasure {
	input -> output
}

// our traffic shaper config should come here
elementclass OurShaper {
	input -> output
}

// this is for checking if packets are valid
elementclass InitialChecks {
	input 
	-> Strip(14)
	-> CheckIPHeader2
	-> output
}

// Our main pipe
FromDevice(eth0) 
	-> OurMeasure
	-> OurShaper
	-> InitialChecks
	-> IPPrint(ok) // print input
	-> Discard; // let's discard for now


