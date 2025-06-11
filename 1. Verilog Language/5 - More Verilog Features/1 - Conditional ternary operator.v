module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//
	
    wire [7:0] ab, cd;
    assign ab = (a < b) ? a : b;
    assign cd = (c < d) ? c : d;
    assign min = (ab < cd) ? ab : cd;

endmodule
