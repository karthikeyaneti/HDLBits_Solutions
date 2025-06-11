module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    wire [7:0] q1, q2, q3;
    
    my_dff8 d1(clk, d, q1);
    my_dff8 d2(clk, q1, q2);
    my_dff8 d3(clk, q2, q3);
    
    assign q = (sel[1]) ? (sel[0]) ? q3 : q2 : (sel[0]) ? q1 : d ;

endmodule
