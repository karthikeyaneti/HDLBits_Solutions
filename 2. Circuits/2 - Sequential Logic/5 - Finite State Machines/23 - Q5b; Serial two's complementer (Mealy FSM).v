module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    
    localparam 	A = 1'b0,
    			B = 1'b1;
    
    reg state, next;
    
    always @(*) begin
        case(state)
            A: begin
                if(x) begin
                    next = B;
                    z = 1'b1;
                end else begin
                    next = A;
                    z = 1'b0;
                end
            end
            B: begin
                next = B;
                z = x ? 1'b0 : 1'b1;
            end
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        if(areset) state <= A;
        else state <= next;
    end

endmodule
