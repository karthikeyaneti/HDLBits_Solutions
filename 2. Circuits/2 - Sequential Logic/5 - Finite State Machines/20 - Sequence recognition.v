module top_module(
	input clk,
	input reset,    // Synchronous reset
	input in,
	output disc,
	output flag,
	output err);

	localparam	S0 = 4'd0,
	S1 = 4'd1,
	S2 = 4'd2,
	S3 = 4'd3,
	S4 = 4'd4,
	S5 = 4'd5,
	S6 = 4'd6,
	DISC = 4'd7,
	FLAG = 4'd8,
	ERR = 4'd9;

	reg [3:0] state, next;

    always @(*) begin
		case(state)
			S0: next = in ? S1 : S0;
			S1: next = in ? S2 : S0;
			S2: next = in ? S3 : S0;
			S3: next = in ? S4 : S0;
			S4: next = in ? S5 : S0;
			S5: next = in ? S6 : DISC;
			S6: next = in ? ERR : FLAG;
			DISC: next = in ? S1 : S0;
			FLAG: next = in ? S1 : S0;
			ERR: next = in ? ERR : S0;
			default: next = S0;
		endcase
	end

    always @(posedge clk) begin
		if(reset) state <= S0;
		else state <= next;
    end

	assign disc = (state == DISC);
	assign flag = (state == FLAG);
	assign err  = (state == ERR);

endmodule