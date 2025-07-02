`timescale 1ps / 1ps
module top_module();
    reg clk, in;
    reg [2:0] s;
    wire out;
    
    q7 dut(.clk(clk), .in(in), .s(s), .out(out));
    
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        in = 1'b0;
        s = 3'd2;
        #10;
        s = 3'd6;
        #10;
        in = 1'b1;
        s = 3'd2;
        #10;
        in = 1'b0;
        s = 3'd7;
        #10;
        in = 1'b1;
        s = 3'b0;
        #30;
        in = 1'b0;
    end
endmodule
