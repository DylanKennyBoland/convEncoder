// Author: Dylan Boland (Student)
// Date: 31/07/2022
//
// This file contains the Verilog description of
// a basic convolutional encoder. The encoding
// rate is 1/2. This means that for every 1 bit
// that goes into the encoder two bits come out.
// 1 information bit is encoded by 2 transmit bits.
//
//
module convEncoder (
	input wire reset, // active-high reset signal for all the flip-flops
	input wire clk, // the input clock signal that drives all the flip-flops
	input wire b0, // the input wire that carries the signal input bit (hence b0)
	output wire c0, // first output bit from the encoder
	output wire c1 // the second output bit from the encoder
	);
	
	// ==== Define some useful internal signals ====
	reg FF1; // flip-flop 1 of the 3 flip-flop register
	reg FF2; // and flip-flop 2 etc.
	reg FF3;
	
	// ==== Output bits Logic ====
	assign c0 = (FF3 ^ FF1); // c0 is the XOR between the outputs of flip-flop 1 and 3
	assign c1 = (FF3 ^ FF2 ^ FF1); // c1 is the XOR between the outputs of all three flip-flops
	
	// ==== Shift register Logic ====
	always @ (posedge clk or posedge reset) // reset is in the sensitivity list, meaning we have asynchronous reset
		if (reset) // i.e., if reset == 1
			// set all the flip-flops to 0 (clear them all)
			FF3 <= 1'b0;
			FF2 <= 1'b0;
			FF1 <= 1'b0;
		else // i.e., we are at the rising edge of the clk signal
			// shift along
			FF3 <= FF2;
			FF2 <= FF1; // flip-flop 2 is loaded with the output of flip-flop 1 etc.
			FF1 <= b0; // flip-flop 1 takes whatever the input bit is

endmodule
		