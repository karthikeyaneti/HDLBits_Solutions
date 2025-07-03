module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);
    
    localparam 	A = 3'd1,
    			B = 3'd2,
    			C = 3'd3,
    			D = 3'd4,
    			E = 3'd5,
    			F = 3'd6;
    
    reg [2:0] state, next;
    
    always @(*) begin
        case(state)
            A: next = w ? A : B;
            B: next = w ? D : C;
            C: next = w ? D : E;
            D: next = w ? A : F;
            E: next = w ? D : E;
            F: next = w ? D : C;
            default: next = A;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) state <= A;
        else state <= next;
    end
    
    assign z = (state == E) || (state == F);

endmodule
