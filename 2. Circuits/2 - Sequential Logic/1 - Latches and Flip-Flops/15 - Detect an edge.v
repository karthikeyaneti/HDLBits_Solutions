module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);
    integer i;
    reg [7:0] temp;
    always @(posedge clk) begin
        for(i = 0; i < 8; i = i + 1) begin
            if(in[i] && !temp[i])
                pedge[i] <= 1'b1;
            else
                pedge[i] <= 1'b0;
        end
        temp <= in;
    end
endmodule
