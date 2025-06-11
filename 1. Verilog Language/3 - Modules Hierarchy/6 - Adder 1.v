module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire carry;
    add16 lower ( a[15:0], b[15:0], 1'b0, sum[15:0], carry);
    add16 upper ( a[31:16], b[31:16], carry, sum[31:16]);

endmodule
