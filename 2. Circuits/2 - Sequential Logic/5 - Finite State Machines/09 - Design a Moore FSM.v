module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    localparam 	s3 		= 3'd5,		// water level above s3
    			s3_s2 	= 3'd4,		// water level above s2 - previous level s3
    			s2_s3 	= 3'd3,		// water level above s2 - previous level s2
    			s2_s1 	= 3'd2,		// water level above s1 - previous level s2
    			s1_s2 	= 3'd1,		// water level above s1 - previous level s1
    			s1		= 3'd0;		// water level below s1
    
    reg [2:0] state, next;
    
    always @(*) begin
        case(state)
            s1 		: next = s[1] ? s1_s2 : s1;
            s1_s2	: next = s[2] ? s2_s3 : (s[1] ? s1_s2 : s1);
            s2_s3	: next = s[3] ?    s3 : (s[2] ? s2_s3 : s2_s1);
            s2_s1	: next = s[2] ? s2_s3 : (s[1] ? s2_s1 : s1);
            s3_s2	: next = s[3] ?    s3 : (s[2] ? s3_s2 : s2_s1);
            s3		: next = s[3] ?    s3 : s3_s2;
        endcase
    end
    
    always @(*) begin
        case(state)
            s1		: {fr3, fr2, fr1, dfr} = 4'b1111;	// water level below sensor 1
            s1_s2	: {fr3, fr2, fr1, dfr} = 4'b0110;	// water level increased above sensor 1
            s2_s3	: {fr3, fr2, fr1, dfr} = 4'b0010;	// water level increased above sensor 2 from sensor 1
            s3		: {fr3, fr2, fr1, dfr} = 4'b0000;	// water level increased above sensor 3
            s3_s2	: {fr3, fr2, fr1, dfr} = 4'b0011;	// water level decreased to sensor 2 from sensor 3
            s2_s1	: {fr3, fr2, fr1, dfr} = 4'b0111;	// water level decreased to sensor 1 from sensor 2
            default	: {fr3, fr2, fr1, dfr} = 4'bxxxx;	// undefined levels (such as when s is 010)
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) state = s1;
        else state = next;
    end

endmodule
