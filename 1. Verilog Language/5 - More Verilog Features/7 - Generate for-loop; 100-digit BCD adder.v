module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    wire [100:0] carry;
    assign carry[0] = cin;
    assign cout = carry[100];
    wire [3:0] a1 [99:0];
    wire [3:0] b1 [99:0];
    wire [3:0] sum1 [99:0];
    
    genvar i;
    generate
        for(i = 0; i < 100; i = i+1) begin : Wiring_Loop
            assign a1[i] = a[4*i +: 4];
            assign b1[i] = b[4*i +: 4];
            assign sum[4*i +: 4] = sum1[i];
        end
    endgenerate
    
    bcd_fadd bcd_fa [99:0] (
        .a(a1),
        .b(b1),
        .cin(carry[99:0]),
        .cout(carry[100:1]),
        .sum(sum1)
    );

endmodule
