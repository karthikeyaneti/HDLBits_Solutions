module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    
    parameter IDLE = 3'd0, STRT = 3'd1, DATA = 3'd2, STOP = 3'd3, DONE = 3'd4;
    reg [2:0] state, next;
    reg [2:0] count;
    
    always @(*) begin
      case(state)
        IDLE: next = (in) ? IDLE : STRT;
        STRT: next = DATA;
        DATA: next = (count == 3'd7) ? ((in) ? DONE : STOP) : DATA;
        STOP: next = (in) ? IDLE : STOP;	// wait till stop bit arrives
        DONE: next = (in) ? IDLE : STRT;
      endcase
    end
    
    always @(posedge clk) begin
        if(reset) begin
            state <= IDLE;
            count <= 3'd0;
        end else begin
            if(state == DATA) begin
                state <= next;
                count <= count + 1'b1;
            end else begin
                state <= next;
                count <= 3'd0;
            end
        end
    end
    
    assign done = (state == DONE);

endmodule
