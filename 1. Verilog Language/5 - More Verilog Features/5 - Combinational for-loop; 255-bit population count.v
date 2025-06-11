module top_module( 
    input [254:0] in,
    output [7:0] out );
    
    reg [7:0] count;
    integer i;
    always @(in) begin
        count = 8'b0;
        for(i = 0; i < 255; i = i + 1) begin
            if(in[i]) count = count + 1'b1;
            else count = count;
        end
    end
    
    assign out = count;

endmodule
