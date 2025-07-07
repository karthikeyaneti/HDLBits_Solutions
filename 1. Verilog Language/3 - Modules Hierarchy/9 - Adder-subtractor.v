module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire cout;
    add16 instance1(a[15:0],b[15:0]^{16{sub}},sub,sum[15:0],cout);
    add16 instance2(a[31:16],b[31:16]^{16{sub}},cout,sum[31:16]);
endmodule
