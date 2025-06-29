module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata
    localparam	STRT = 3'd0,
    			DATA = 3'd1,
    			PRTY = 3'd2,
    			STOP = 3'd3,
    			WAIT = 3'd4,
    			DONE = 3'd5;
    
    reg [2:0] state, next;
    reg [3:0] count;
    reg [7:0] data;
    wire odd, odd_reset;
    
    always @(*) begin
        case(state)
            STRT: next = (in) ? STRT : DATA;
          	DATA: next = (count == 4'd7) ? PRTY : DATA;
          	PRTY: next = (in == !odd) ? STOP : WAIT;
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
            data  <= 8'd0;
        end
        else begin
            state <= next;
            if(state == DATA) begin
                count <= count + 1'd1;
                data  <= {in, data[7:1]};
            end else begin
                count <= 4'd0;
            end
        end
    end
    

    // New: Add parity checking.
  	assign odd_reset = (state == STRT) || reset;

  	parity odd_parity(.clk(clk), .reset(odd_reset), .in(in), .odd(odd)); 
    
    assign done = (state == DONE);
    assign out_byte = data;

endmodule