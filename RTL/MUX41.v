module MUX41 (
    input [31:0] r1,
    input [31:0] r2,
    input [31:0] r3,
    input [31:0] r4,
    input [1:0] s,
    output reg [31:0] r
);
    always @(*)
        case (s)
        2'b00 : r = r1;
        2'b01 : r = r2;
        2'b10 : r = r3;
        2'b11 : r = r4;
        default :r = r1;
        endcase
endmodule
