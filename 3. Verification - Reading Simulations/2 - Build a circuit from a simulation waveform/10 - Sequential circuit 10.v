module top_module (
    input clk,
    input a,
    input b,
    output q,
    output reg state);
	
    assign q = (state) ? ~(a ^ b) : (a ^ b);
    always @(posedge clk) state <= (a == b) ? a : state;
    
endmodule
