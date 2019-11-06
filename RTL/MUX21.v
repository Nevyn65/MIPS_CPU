module MUX21(
    input [31:0] i1,
    input [31:0] i2,
    input s,
    output [31:0] o
);
    assign o = (s == 1'b0) ? i1 : i2;
endmodule
