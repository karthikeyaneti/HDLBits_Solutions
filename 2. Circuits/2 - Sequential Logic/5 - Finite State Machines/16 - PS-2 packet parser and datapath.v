module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    reg [23:0] data;
    
    // FSM from fsm_ps2
    parameter B1 = 2'd1, B2 = 2'd2, B3 = 2'd3, DONE = 2'd0;
    reg [1:0] state, next;
    
    always @(*) begin
        case(state)
            B1: next = in[3] ? B2 : B1;
            B2: next = B3;
            B3: next = DONE;
            DONE: next = in[3] ? B2 : B1;

        endcase
    end
            
    always @(posedge clk) begin
        if(reset) state <= B1;
        else state <= next;
    end

    // New: Datapath to store incoming bytes.
    
    always @(posedge clk) begin
        if(reset) data <= 24'd0;
        else data <= {data[15:8], data[7:0], in};
    end

	assign done = (state == DONE);
    assign out_bytes = (done) ? data : 24'd0;

endmodule
