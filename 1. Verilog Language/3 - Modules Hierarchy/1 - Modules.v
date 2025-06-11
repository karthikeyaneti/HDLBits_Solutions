module top_module ( input a, input b, output out );
    // mod_a instance1 (a,b,c);
    mod_a instance2 (.in1(a), .in2(b), .out(out));
endmodule
