module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output z
);
    
    localparam 	A = 3'd1,
    			B = 3'd2,
    			C = 3'd3,
    			D = 3'd4,
    			E = 3'd5,
    			F = 3'd6;
    
    reg [2:0] state, next;
    
    always @(*) begin
        case({state,w})
            {A,1'b0}: next = A;
            {A,1'b1}: next = B;
            {B,1'b0}: next = D;
            {B,1'b1}: next = C;
            {C,1'b0}: next = D;
            {C,1'b1}: next = E;
            {D,1'b0}: next = A;
            {D,1'b1}: next = F;
            {E,1'b0}: next = D;
            {E,1'b1}: next = E;
            {F,1'b0}: next = D;
            {F,1'b1}: next = C;
            default: next = A;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) state <= A;
        else state <= next;
    end
    
    assign z = (state == E) || (state == F);

endmodule
