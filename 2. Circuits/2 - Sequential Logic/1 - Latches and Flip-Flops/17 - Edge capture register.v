module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    integer i;
    reg [31:0] temp;
    always @(posedge clk) begin
        if(reset) begin
            out <= 32'd0;
        	temp <= in;
        end
        else begin
            for(i = 0; i < 32; i = i + 1) begin
                if(temp[i] && !in[i])
                    out[i] <= 1'b1;
            end
            temp <= in;
        end
    end

endmodule
