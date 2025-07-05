module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
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
    reg [3:0] delay;
    reg [1:0] i;
    reg [9:0] t;
    
    always @(*) begin
        case(state)
            S0: next = data ? S1 : S0;
            S1: next = data ? S2 : S0;
            S2: next = data ? S2 : S3;
            S3: next = data ? S4 : S0;
            S4: next = S5;
            S5: next = S6;
            S6: next = ack ? S0 : S6;
            default: next = S0;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) begin
            state <= S0;
            delay <= 4'd0;
            i <= 2'd0;
            t <= 10'd0;
        end
        else begin
            if(state == S4) begin
                delay <= {delay[2:0], data};
                if(i < 2'd3) begin
                    state <= S4;
                    i <= i + 1'd1;
                end else begin
                    state <= next;
                    i <= 2'd0;
                end
            end
            else if(state == S5) begin
                if(t < 10'd999) begin
                    t <= t + 1'b1;
                end else begin
                    t <= 10'd0;
                    if(delay != 4'd0) begin
                       delay <= delay - 1'b1; 
                    end else begin
                        state <= next;
                    end
                end
            end
            else begin
                state <= next;
                delay <= 4'd0;
                i <= 2'd0;
                t <= 10'd0;
            end
        end
    end
    
    assign counting = (state == S5);
    assign done		= (state == S6);
    assign count 	= delay;

endmodule
