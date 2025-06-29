module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
	
    localparam LEFT = 3'b000, RIGHT = 3'b001, FALL_LEFT = 3'b010, FALL_RIGHT = 3'b011,
    			DIG_LEFT = 3'b100, DIG_RIGHT = 3'b101, SPLATTER = 3'b110;
    reg [2:0] state, next;
    integer count;
    
    always @(*) begin 
        case(state)
            LEFT: begin
                if(!ground) next = FALL_LEFT;
                else if(dig) next = DIG_LEFT;
                else if(bump_left) next = RIGHT;
                else next = LEFT;
            end
            RIGHT: begin
                if(!ground) next = FALL_RIGHT;
                else if(dig) next = DIG_RIGHT;
                else if(bump_right) next = LEFT;
                else next = RIGHT;
            end
            FALL_LEFT: begin
                if((count > 20) && ground) next = SPLATTER;
                else next = ground ? LEFT : FALL_LEFT;
            end
            FALL_RIGHT: begin
                if((count > 20) && ground) next = SPLATTER;
                else next = ground ? RIGHT : FALL_RIGHT;
            end
            DIG_LEFT: next = ground ? DIG_LEFT : FALL_LEFT;
            DIG_RIGHT: next = ground ? DIG_RIGHT : FALL_RIGHT;
            SPLATTER: next = SPLATTER;
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            state <= LEFT;
            count <= 0;
        end else begin
            state <= next;
            if(next == FALL_LEFT || next == FALL_RIGHT) begin            
                count <= count + 1'd1;
        	end else begin
                count <= 0;
            end
        end
    end
    
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = ((state == FALL_LEFT) || (state == FALL_RIGHT));
    assign digging = ((state == DIG_LEFT) || (state == DIG_RIGHT));
endmodule
