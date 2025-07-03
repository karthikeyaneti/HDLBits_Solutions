module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    localparam 	A = 3'b000,
    			B = 3'b001,
    			C = 3'b010,
    			D = 3'b100;
    
    reg [3:1] state, next;
    
    always @(*) begin
        case(state)
            A: begin
                if (r[1]) next = B;
                else if (r[2]) next = C;
                else if (r[3]) next = D;
                else next = A;
            end
            B: next = (r[1]) ? B : A;
            C: next = (r[2]) ? C : A;
            D: next = (r[3]) ? D : A;
            default: next = A;
        endcase
    end
    
    always @(posedge clk) begin
        if(!resetn) state <= A;
        else state <= next;
    end
    
    assign g = state;

endmodule
