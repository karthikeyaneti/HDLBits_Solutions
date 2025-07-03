module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

    localparam A = 1'b0,
               B = 1'b1;

    reg state, next;
	reg [1:0] clk_cnt, w_cnt;

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            clk_cnt <= 2'd0;
            w_cnt <= 2'd0;
        end else begin
            if (state == A) begin
              if(s) begin
              	state <= B;
                clk_cnt <= 2'd0;
                w_cnt <= 2'd0;
              end else begin
                state <= A;
                clk_cnt <= 2'd0;
                w_cnt <= 2'd0;
              end
            end else if (state == B) begin
              	if (clk_cnt == 2'd3) clk_cnt <= 2'd1;
              	else clk_cnt <= clk_cnt + 1'b1;
              	w_cnt <= (clk_cnt == 2'd3) ? w : w_cnt + w;
            end
        end
    end

  assign z = (clk_cnt == 2'd3 && w_cnt == 2'd2);

endmodule