module top_module (
    input clk,
    input reset,       // Synchronous reset
    output reg shift_ena
);

    reg [2:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 3'd0;
            shift_ena <= 1'b1;
        end else if (shift_ena) begin
            if (count == 3'd3) shift_ena <= 1'b0;
			else count <= count + 1'b1;
        end
    end

endmodule