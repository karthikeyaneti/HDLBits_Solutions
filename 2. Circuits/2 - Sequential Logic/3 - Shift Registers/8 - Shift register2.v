module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    wire clk = KEY[0];
    wire E = KEY[1];
    wire L = KEY[2];
    wire w = KEY[3];

    MUXDFF MDFF3(clk, E, L, w, LEDR[3], SW[3], LEDR[3]);
    MUXDFF MDFF2(clk, E, L, LEDR[3], LEDR[2], SW[2], LEDR[2]);
    MUXDFF MDFF1(clk, E, L, LEDR[2], LEDR[1], SW[1], LEDR[1]);
    MUXDFF MDFF0(clk, E, L, LEDR[1], LEDR[0], SW[0], LEDR[0]);

endmodule

module MUXDFF (clk, E, L, w, m0, R, q);
    input clk, E, L, w, m0, R;
    output reg q;
    
    wire mux2_0 = E ? w : m0;
    wire d = L ? R : mux2_0; 
    
    always @(posedge clk) begin
        q <= d; 
    end

endmodule
