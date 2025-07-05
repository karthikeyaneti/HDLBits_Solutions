module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output reg start_shifting);
    
    localparam 	S0 = 3'd0,
    			S1 = 3'd1,
    			S2 = 3'd2,
    			S3 = 3'd3,
    			S4 = 3'd4;
    
    reg [2:0] state, next;
    
    always @(*) begin
        case(state)
            S0: next = data ? S1 : S0;
            S1: next = data ? S2 : S0;
            S2: next = data ? S2 : S3;
            S3: next = data ? S4 : S0;
            S4: next = S4;
            default: next = S0;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) state <= S0;
        else state <= next;
    end
    
    assign start_shifting = (state == S4);

endmodule
