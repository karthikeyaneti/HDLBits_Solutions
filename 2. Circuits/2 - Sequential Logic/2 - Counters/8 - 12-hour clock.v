module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss); 
    
    always @(posedge clk) begin
        if(reset) begin
            {hh, mm, ss, pm} = {8'h12, 8'h0, 8'h0, 1'b0};
        end else if (ena) begin
            if(ss == 8'h59) begin
                ss <= 8'h0;
                
                if(mm == 8'h59) begin
                    mm <= 8'h0;
                    
                    if(hh == 8'h11) begin
                        hh <= 8'h12;
                        pm <= ~pm;
                    end
                    else if(hh == 8'h12) 
                        hh <= 8'h01;
                    else
                        hh <= (hh[3:0] == 4'd9) ? {hh[7:4] + 1'd1, 4'd0} : {hh[7:4], hh[3:0] + 4'd1};
                    
                end else
                    mm <= (mm[3:0] == 4'd9) ? {mm[7:4] + 1'd1, 4'd0} : {mm[7:4], mm[3:0] + 4'd1};
                
            end else 
                ss <= (ss[3:0] == 4'd9) ? {ss[7:4] + 1'd1, 4'd0} : {ss[7:4], ss[3:0] + 4'd1};  
        end
    end

endmodule
