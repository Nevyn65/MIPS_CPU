module EXT_16 (
    input s_ext_s, // Means of extention.
    input [15:0] data_in, //Data to input.
    output [31:0] data_out //Data to output.
);
    assign data_out = s_ext_s ? {{16{data_in[15]}}, data_in} : {16'b0, data_in};
endmodule
