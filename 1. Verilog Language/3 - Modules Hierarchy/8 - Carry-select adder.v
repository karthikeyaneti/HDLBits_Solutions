module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire carry_sel;
    wire [31:16] sum_0;
    wire [31:16] sum_1;
    add16 lower(a[15:0], b[15:0], 1'b0, sum[15:0], carry_sel);
    add16 higher0(a[31:16], b[31:16], 1'b0, sum_0);
    add16 higher1(a[31:16], b[31:16], 1'b1, sum_1);
    assign sum[31:16] = carry_sel ? sum_1 : sum_0;

endmodule
