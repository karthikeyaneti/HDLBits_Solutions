module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );

    wire w1a, w1b, w2a, w2b;
    assign w1a = p1a & p1c & p1b;
    assign w1b = p1f & p1e & p1d;
    assign w2a = p2a & p2b;
    assign w2b = p2c & p2d;
    assign p1y = w1a | w1b;
    assign p2y = w2a | w2b;

endmodule
