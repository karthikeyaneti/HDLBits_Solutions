module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    
    fadd fa3 [2:0] (.a(a), .b(b), .cin({cout[1:0],cin}), .cout(cout[2:0]), .sum(sum));  

endmodule

module fadd( input a, b, cin, output cout, sum);
    assign cout = (a & b) | (cin & (a ^ b));
    assign sum = a ^ b ^ cin;
endmodule
