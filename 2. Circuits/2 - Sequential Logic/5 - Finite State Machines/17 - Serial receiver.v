module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    
    localparam	STRT = 3'd0,
    			DATA = 3'd1,
    			STOP = 3'd2,
    			WAIT = 3'd3,
    			DONE = 3'd4;
    
  	reg [2:0] 	state, next;
    reg [3:0] 	count;
    
    always @(*) begin
        case(state)
            STRT: next = (in) ? STRT : DATA;
            DATA: next = (count == 4'd7) ? STOP : DATA;
            STOP: next = (in) ? DONE : WAIT;
            WAIT: next = (in) ? STRT : WAIT;
            DONE: next = (in) ? STRT : DATA;
            default: next = STRT;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) begin
            state <= STRT;
            count <= 4'd0;
        end
        else begin
            state <= next;
            if(state == DATA)
                count <= count + 1'd1;
            else 
                count <= 4'd0;
        end
    end
    
    assign done = (state == DONE);

endmodule
