module PC (
    input clk, //Clock signal. Input when posedge.
    input rst,      // HI to reset.
    input [31:0] data_in, //Data to input.
    output [31:0] data_out //Data to output.
);
    reg [31:0]rom;
    assign data_out =  rom ;
    always @(negedge clk or posedge rst)
        if (rst)
            rom <= 32'h0040_0000;
        else
            rom <= data_in;
endmodule
