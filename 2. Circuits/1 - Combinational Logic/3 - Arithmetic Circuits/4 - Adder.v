module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    
    wire [3:1] carry;
    fa fa4 [3:0] (.a(x), .b(y), .cin({carry, 1'b0}), .cout({sum[4], carry}), .sum(sum[3:0]));

endmodule

module fa (input a, b, cin, output cout, sum);
    assign cout = (a & b) | (cin & (a ^ b));
    assign sum = a ^ b ^ cin;
endmodule
