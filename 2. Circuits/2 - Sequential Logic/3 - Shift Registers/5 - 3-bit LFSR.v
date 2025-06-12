module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q

    mux_dff d0(KEY[0], KEY[1], LEDR[2], SW[0], LEDR[0]);
    mux_dff d1(KEY[0], KEY[1], LEDR[0], SW[1], LEDR[1]);
    mux_dff d2(KEY[0], KEY[1], LEDR[1] ^ LEDR[2], SW[2], LEDR[2]);
endmodule

module mux_dff(clk, L, qp, r, q);
    input clk, L, qp, r;
    output reg q;
    
    always @(posedge clk) begin
        q <= (L) ? r: qp;
    end
endmodule
