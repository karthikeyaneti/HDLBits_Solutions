`timescale 1ps / 1ps
module top_module ();
    reg clk, reset, t;
    wire q;
    
    tff t_flip_flop (.clk(clk), .reset(reset), .t(t), .q(q));
    
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        t = 1'b0;
        reset = 1'b0;
        @(posedge clk) reset <= 1'b1;
        @(posedge clk) reset <= 1'b0;
        @(posedge clk) t <= 1'b1;
    end
endmodule
