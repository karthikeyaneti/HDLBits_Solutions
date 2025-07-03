module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    
    localparam 	A = 3'b000,
    			B = 3'b001,
    			C = 3'b010,
    			D = 3'b011,
    			E = 3'b100;
    
    reg [2:0] Y;
    
    always @(*) begin
        case(y)
            A: Y = x ? B : A;
            B: Y = x ? E : B;
            C: Y = x ? B : C;
            D: Y = x ? C : B;
            E: Y = x ? E : D;
            default: Y = A;
        endcase
    end
    
    assign z = (y == D) || (y == E);
    assign Y0 = Y[0];

endmodule
