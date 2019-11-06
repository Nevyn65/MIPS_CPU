module MUX5_21(
    input [4:0] i1,
    input [4:0] i2,
    input s,
    output [4:0] o
);
    assign o = (s == 1'b0) ? i1 : i2;
endmodule
