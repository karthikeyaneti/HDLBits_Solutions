module top_module (input a, input b, input c, output out);
	
    wire and3;
    assign out = ~and3;
    andgate inst1 ( and3, a, b, c, 1'b1, 1'b1 );

endmodule
