`timescale 1ps / 1ps
module top_module ( );
	reg clk;
    dut dut1(clk);
    
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end
endmodule
