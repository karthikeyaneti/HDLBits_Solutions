module top_module (
    input clock,
    input a,
    output reg p,
    output reg q );

    always @(*) if(clock) p = a;
    always @(negedge clock) q <= a;
endmodule
