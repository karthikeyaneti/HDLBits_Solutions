module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
	
    BCD_digit d0(clk, reset, 1'b1, q[3:0], ena[1]);
    BCD_digit d1(clk, reset, ena[1], q[7:4], ena[2]);
    BCD_digit d2(clk, reset, ena[2], q[11:8], ena[3]);
    BCD_digit d3(clk, reset, ena[3], q[15:12]);
    
endmodule
               
module BCD_digit(clk, rst, ena_in, digit, ena_out);
    input clk, rst, ena_in;
    output reg [3:0] digit;
    output ena_out;
    
    always @(posedge clk) begin
        if(rst) 
            digit <= 4'd0;
        else if(ena_in) begin
            if(digit == 4'd9) 
                digit <= 4'd0;
            else 
                digit <= digit + 4'd1;
        end
    end
    
    assign ena_out = (digit == 4'd9) && ena_in;

endmodule
