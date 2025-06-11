module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    
    wire [31:0] b1;
    wire carry;
    assign b1 = b ^ {32{sub}};
    
    add16(a[15:0], b1[15:0], sub, sum[15:0], carry);
    add16(a[31:16], b1[31:16], carry, sum[31:16]);      

endmodule
