module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output reg z );
    
    localparam 	S0 = 2'd0,
 	              S1 = 2'd1,
                S2 = 2'd2;
    
    reg [1:0] state, next;
    
    always @(*) begin
        case(state)
            S0: begin
                next = x ? S1 : S0;
                z = 1'b0;
            end
            S1: begin
                next = x ? S1 : S2;
                z = 1'b0;
            end
            S2: begin
              if(x) begin
                next = S1;
                z = 1'b1;
              end else begin
                next = S0;
                z = 1'b0;
              end
            end
            default: begin 
                next = S0;
                z = 1'b0;
            end
        endcase
    end
    
  	always @(posedge clk or negedge aresetn) begin
      	if(!aresetn) state <= S0;
        else state <= next;
    end
    
endmodule