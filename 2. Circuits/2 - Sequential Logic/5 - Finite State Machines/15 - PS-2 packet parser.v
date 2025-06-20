module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //

    parameter B1 = 2'd1, B2 = 2'd2, B3 = 2'd3, DONE = 2'd0; 
    reg [1:0] state, next;
    
    // State transition logic (combinational)
    always @(*) begin
        case(state)
            B1: next = in[3] ? B2 : B1;
            B2: next = B3;
            B3: next = DONE;
            DONE: next = in[3] ? B2 : B1;
        endcase
    end
    
    // State flip-flops (sequential)
    always @(posedge clk) begin
        if(reset) state <= B1;
        else state <= next;
    end
 
    // Output logic
    assign done = (state == DONE);

endmodule
