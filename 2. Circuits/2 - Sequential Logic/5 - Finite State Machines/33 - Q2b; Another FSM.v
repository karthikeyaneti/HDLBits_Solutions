module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    
    localparam 	A = 4'd0,
    			B = 4'd1,
    			C = 4'd2,
    			D = 4'd3,
    			E = 4'd4,
    			F = 4'd5,
    			G = 4'd6,
    			H = 4'd7,
    			I = 4'd8;
    
    reg [3:0] state, next;
    
    always @(*) begin
        case(state)
            A: next = B;
            B: next = C;
            C: next = x ? D : C;
            D: next = x ? D : E;
            E: next = x ? F : C;
            F: next = G;
            G: next = y ? H : I;
            H: next = H;
            I: next = I;
            default: next = A;
        endcase
    end
    
    always @(posedge clk) begin
        if(!resetn) state <= A;
        else state <= next;
    end
    
    assign f = (state == B);
    assign g = (state == F) || (state == G) || (state == H);

endmodule
