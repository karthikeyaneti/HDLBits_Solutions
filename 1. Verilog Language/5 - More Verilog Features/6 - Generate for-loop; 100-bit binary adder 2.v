module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
    wire [100:0] carry;
    assign carry[0] = cin;
    assign cout = carry[100:1];
    
    full_adder fa[99:0] ( .a(a), .b(b), .cin(carry[99:0]), .cout(carry[100:1]), .sum(sum));

endmodule

module full_adder ( input a, b, cin, output cout, sum);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule
