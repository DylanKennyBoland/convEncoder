// Author: Dylan Boland (Student)
//
// This is a very basic testbench for the convEncoder module
// that models a basic convolutional encoder, with an encoding rate
// of 1/2, meaning for every 1 bit that goes into the encoder two bits
// come out - that is, each input bit is encoded to two code bits.
//

module TB_convEncoder; // the testbench module name (no input or output ports)
	// ==== Define the internal stimulus signals ====
	// all these reg-type signals are, by default, 1 bit wide
	reg reset;
	reg clk;
	reg b0;
	// the wires below will be driven by the outputs of the device under test (DUT)
	wire c0;
	wire c1;
	
	// ==== Instantiate the Design Module - the Device Under Test (DUT) ====
	convEncoder dut ( // module name: convEncoder, instance name: dut
		.reset(reset),
		.clk(clk),
		.b0(b0),
		.c0(c0),
		.c1(c1)
		);
	
	// ==== Generate the Clock signal (clk) ====
	initial
	begin
		clk = 1'b0; // clk is initially 0 (it idles lows)
		forever
			#10 clk = ~clk; // generates a 50 MHz clock signal
	end
	
	// ==== Generate Stimulus input Signals ====
	initial
	begin
		// ==== Initialise the Signal Values first ====
		reset = 1'b0;
		b0 = 1'b0;
		// now start to change the input bit (b0)
		#15 b0 = 1'b1;
		#20 b0 = 1'b0;
		#15 b0 = 1'b1;
		#25 b0 = 1'b0;
		#10 reset = 1'b1;
		#10 reset = 1'b0;
		#15 b0 = 1'b1;
		#10 b0 = 1'b0;
		// ==== End of the Simulation ====
		#100;
		$stop;
	end
	
endmodule