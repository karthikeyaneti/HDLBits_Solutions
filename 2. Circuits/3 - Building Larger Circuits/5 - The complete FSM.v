module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    localparam 	S0 = 3'd0,
    			S1 = 3'd1,
    			S2 = 3'd2,
    			S3 = 3'd3,
				S4 = 3'd4,
    			S5 = 3'd5,
    			S6 = 3'd6;
    
    reg [2:0] state, next;
    reg [2:0] count;
    
    always @(*) begin
        case(state)
            S0: next = data ? S1 : S0;
            S1: next = data ? S2 : S0;
            S2: next = data ? S2 : S3;
            S3: next = data ? S4 : S0;
            S4: next = S5;
            S5: next = done_counting ? S6 : S5;
            S6: next = ack ? S0 : S6;
            default: next = S0;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) state <= S0;
        else begin
            if(state == S4) begin
                if(count < 3'd3) begin
                    state <= S4;
                    count <= count + 1'd1;
                end else begin
                    state <= next;
                    count <= 2'd0;
                end
            end
            else begin
                state <= next;
                count <= 2'd0;
            end
        end
    end
    
    assign shift_ena = (state == S4);
    assign counting  = (state == S5);
    assign done		 = (state == S6);
    
endmodule
