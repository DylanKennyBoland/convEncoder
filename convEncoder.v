// Author: Dylan Boland (Student)
//
// This is a Verilog description of a basic convolutional
// encoder. The "encoding rate" is 1/2, meaning every 1 bit
// that goes into the encoder generates two output bits. That is,
// every bit is encoded by two bits.
//
module convEncoder (
	input wire reset, // the active-high reset signal for the shift register
	input wire clk, // the clock signal that drives all the flip-flops
	input wire b0, // the bit going into the encoder
	output wire c0, // the first output bit
	output wire c1 // the second output bit
	);
	
	// ==== Define some useful internal signals ====
	reg FF1; // flip-flop 1 of the 3 flip-flop register
	reg FF2; // and flip-flop 2 etc.
	reg FF3;
	
	// ==== Output bits Logic ====
	// we can specify how each of the two bits is computed or calculated:
	assign c0 = (FF3 ^ FF1); // the first bit is the XOR between the outputs of flip-flop 1 and 3
	assign c1 = (FF3 ^ FF2 ^ FF1); // the second bit is the XOR between the outputs of all three flip-flops
	
	// ==== Shift register Logic ====
	always @ (posedge clk or posedge reset)
	begin
		if (reset) // i.e., if reset == 1
		begin
			FF3 <= 1'b0;
			FF2 <= 1'b0;
			FF1 <= 1'b0;
		end
		else // else, we are at the rising edge of a clock pulse
		begin
			FF3 <= FF2;
			FF2 <= FF1; // flip-flop 2 is loaded with the output of flip-flop 1 etc.
			FF1 <= b0; // flip-flop 1 takes whatever the input bit is
		end
	end
	
endmodule