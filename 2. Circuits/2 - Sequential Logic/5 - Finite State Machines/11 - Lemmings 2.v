module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter LEFT = 2'b00, RIGHT = 2'b01, FALL_LEFT = 2'b10, FALL_RIGHT = 2'b11;
    reg [1:0] state, next;
    
    always @(*) begin
        case(state)
            LEFT: next = ground ? (bump_left ? RIGHT : LEFT) : FALL_LEFT;
            RIGHT: next = ground ? (bump_right ? LEFT : RIGHT) : FALL_RIGHT;
            FALL_LEFT: next = ground ? LEFT : FALL_LEFT;
            FALL_RIGHT: next = ground ? RIGHT : FALL_RIGHT;
        endcase
    end
    			
    
    always @(posedge clk or posedge areset) begin
        if(areset) state <= LEFT; 
        else state <= next;
    end
    
    assign aaah = state[1];	// FALL_LEFT or FALL_RIGHT
    assign walk_left = state == LEFT;
    assign walk_right = state == RIGHT;

endmodule
