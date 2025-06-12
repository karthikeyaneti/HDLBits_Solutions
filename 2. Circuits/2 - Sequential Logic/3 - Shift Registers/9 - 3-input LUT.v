module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 
    
    reg [0:7] Q;
    always @(posedge clk) begin
        if(enable) 
            Q <= {S,Q[0:6]};
        else
            Q <= Q;
    end
    
    assign Z = Q[{A,B,C}];

endmodule
