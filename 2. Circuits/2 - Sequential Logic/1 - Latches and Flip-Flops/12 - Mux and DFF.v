module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    
    always @(posedge clk) begin
        Q <= (L) ? R : (E) ? w : Q;
    end

endmodule
