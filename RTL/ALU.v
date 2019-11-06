module alu(
	input 		[31:0]	a,			//32 bit input. Operand 1.
    input 		[31:0]	b,			//32 bit input. Operand 2.
    input 		[3:0]	aluc,		//4 bit input. control alu.
    output reg 	[31:0]	r,			//32 bit output.
    output reg			zero,		//ZERO flag.
    output reg 			carry,		//CARRY flag.
    output  			negative,	//NEGATIVE flag.
    output reg 			overflow	//OVERFLOW flag.
);
    reg 		[32:0] rr;
    reg signed 	[31:0] bb;

    always @ (*) begin
    	case(aluc)
    		// ADDU
    		4'b0000: begin
        		rr = a + b;
        		r = rr[31:0];
        		carry = rr[32];
        		zero = r;
    		end

    		// ADD
    		4'b0010: begin
    			rr = a + b;
				r = rr[31:0];
        		if(rr[32] != rr[31] && a[31] == b[31])
            		overflow = 1;
        		else
            		overflow = 0;
            	zero = r;
    		end

    		// SUBU
    		4'b0001: begin
        		r = a - b;
        		if(a < b)
            		carry = 1;
        		else
            		carry = 0;
                zero = r;
    		end

    		// SUB
    		4'b0011:
				begin
        		r = a - b;
        		if(a[31] != b[31] && a[31] != r[31])
            		overflow = 1;
        		else
            		overflow = 0;
             	zero = r;
    		end

    		// AND
    		4'b0100: 
    		    begin
    		    r = a & b;
        		zero = r;
        		end
    		// OR
    		4'b0101: 
    		begin
    		r = a | b;
        	zero = r;
        	end    		

    		// XOR
    		4'b0110:
    		begin
    		 r = a ^ b;
    		 zero = r;
    		 end

    		// NOR
    		4'b0111: 
    		begin
    		r = ~(a | b);
    		zero = r;
    		end

    		// LUI
    		4'b1000: 
    		begin
    		r = {b[15:0], 16'b0};
    		zero = r;
    		end

    		// SLT, compare, include the use of beq/ bne
    		4'b1011:
			  begin

        		if((a[31] == b[31] && a < b) || (a[31] == 1 && b[31] == 0))
            		begin
            	    r <= 1; 
            		zero <= 0;
            		end
        		else if( a == b)
        		  begin
            		r = 0; zero = 1;
            		end
			   else 
			         begin 
			         r = 0; zero = 0;
			         end
			    end

    		// SLTU
    		4'b1010: begin
        		r = (a < b) ? 1 : 0;
        		carry = r;
        		zero = r;
    		end

    		// SRA
    		4'b1100: begin
        		r = b >> a;
        		carry = r[0];
        		bb = b;
        		r = bb >>> a;
                zero = r;
    		end

    		// SLL
    		4'b1110: begin
        		r = b << (a - 1);
        		carry = r[31];
        		r = b << a;
        		zero = r;
    		end

    		// SRL
    		4'b1101: begin
    			r = b >> (a-1);
        		carry = r[0];
        		r = b >> a;
        		zero = r;
    		end
		endcase
    end


endmodule
