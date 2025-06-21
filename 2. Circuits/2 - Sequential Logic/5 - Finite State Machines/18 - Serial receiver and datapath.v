module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    reg [7:0] out;
    
    // Use FSM from Fsm_serial
    parameter IDLE = 2'd0, DATA = 2'd1, STOP = 2'd2, DONE = 2'd3;
  	reg [1:0] state, next;
  	reg [3:0] count;
    
    always @(*) begin
        case(state)
          IDLE: next = (in) ? IDLE : DATA;
          DATA: next = (count == 4'd9) ? (in) ? DONE : STOP : DATA;
          STOP: next = (in) ? IDLE : STOP;
          DONE: next = (in) ? IDLE : DATA;
          default: next = IDLE;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) begin
            state <= IDLE;
            count <= 4'd0;
        end else begin
            if(next == DATA) begin
                state <= next;
                count <= count + 1'b1;
            end else begin
                state <= next;
                count <= 4'd0;
            end
        end
    end

    // New: Datapath to latch input bits.
        
  	always @(posedge clk) begin
        if(reset) 
            out <= 8'b0;
        else if(state == DATA && count >= 4'd1 && count <= 4'd8)
            out[count-1] <= in;
    end

	assign done = (state == DONE);
    assign out_byte = (done) ? out : 8'd0;
  

endmodule
