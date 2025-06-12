module top_module (
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    reg [255:0] next;
    integer i, j;

    function [3:0] wrap(input integer index);
        begin
            if (index < 0)
                wrap = 4'd15;
            else if (index > 15)
                wrap = 4'd0;
            else
                wrap = index[3:0];
        end
    endfunction

    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                integer r, c;
                integer count;
                count = 0;

                // Count 8 neighbors
                for (r = -1; r <= 1; r = r + 1) begin
                    for (c = -1; c <= 1; c = c + 1) begin
                        if (!(r == 0 && c == 0)) begin
                            integer ni, nj;
                            ni = wrap(i + r);
                            nj = wrap(j + c);
                            count = count + q[ni*16 + nj];
                        end
                    end
                end

                if (count == 3)
                    next[i*16 + j] = 1'b1;
                else if (count == 2)
                    next[i*16 + j] = q[i*16 + j];
                else
                    next[i*16 + j] = 1'b0;
            end
        end
    end

    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next;
    end

endmodule
