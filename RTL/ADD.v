module ADD(
    input [31:0] in_A,      // Input 32bit A.
    input [31:0] in_B,      // Input 31bit B.
    output [31:0] o
);
    assign o = in_A + in_B;
endmodule
