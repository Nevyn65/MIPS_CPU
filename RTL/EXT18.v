module EXT_18 (
    input s_ext_s, // Means of extention.
    input [15:0] data_in, //Data to input.
    output [31:0] data_out //Data to output.
);
    assign data_out = s_ext_s ? {{14{data_in[15]}}, data_in, 2'b0} : {14'b0, data_in, 2'b0};

endmodule
