module top_module( 
    input [2:0] in,
    output reg [1:0] out );
	integer i;
    
    always @(*) begin
       out = 1'b0;
        for(i = 0; i < 2'd3; i = i + 1) begin
            if(in[i]) out = out + 1'b1;
        end
    end
    
endmodule
