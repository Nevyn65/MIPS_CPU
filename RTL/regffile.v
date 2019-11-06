`timescale 1ns / 1ps
module regfile(
    input clk,      // Input at negedge.
    input rst,      // HI to reset.
    input ena,      // HI to enable.
    input we,       // HI to write, LO to read.
    input use_jal,
    input [31:0] w_R31,
    input sw_ena,
    input [4:0] raddr1, // Read address 1.
    input [4:0] raddr2, // Read address 2.
    input [4:0] waddr,  // Write address.
    input [31:0] wdata, // Data to write.
    output [31:0] dm_in, // data sent to DM
    output [31:0] rdata1, // Data 1 to output.
    output [31:0] rdata2, // Data 2 to output.
    output [31:0] reg_31
    );

    reg [31:0] array_reg[0:31];
    
    assign dm_in = (ena & sw_ena)?  array_reg[waddr]:32'hzzzzzzzz;
    assign rdata1 = ena ? array_reg[raddr1] : 32'hzzzzzzzz;
    assign rdata2 = ena ? array_reg[raddr2] : 32'hzzzzzzzz;
    always @(negedge clk or posedge rst)
        begin
        if (rst)
        begin
        array_reg[0] <= 32'h00000000;
        array_reg[1] <= 32'h00000000;
        array_reg[2] <= 32'h00000000;
        array_reg[3] <= 32'h00000000;
        array_reg[4] <= 32'h00000000;
        array_reg[5] <= 32'h00000000;
        array_reg[6] <= 32'h00000000;
        array_reg[7] <= 32'h00000000;
        array_reg[8] <= 32'h00000000;
        array_reg[9] <= 32'h00000000;
        array_reg[10] <= 32'h00000000;
        array_reg[11] <= 32'h00000000;
        array_reg[12] <= 32'h00000000;
        array_reg[13] <= 32'h00000000;
        array_reg[14] <= 32'h00000000;
        array_reg[15] <= 32'h00000000;
        array_reg[16] <= 32'h00000000;
        array_reg[17] <= 32'h00000000;
        array_reg[18] <= 32'h00000000;
        array_reg[19] <= 32'h00000000;
        array_reg[20] <= 32'h00000000;
        array_reg[21] <= 32'h00000000;
        array_reg[22] <= 32'h00000000;
        array_reg[23] <= 32'h00000000;
        array_reg[24] <= 32'h00000000;
        array_reg[25] <= 32'h00000000;
        array_reg[26] <= 32'h00000000;
        array_reg[27] <= 32'h00000000;
        array_reg[28] <= 32'h00000000;
        array_reg[29] <= 32'h00000000;
        array_reg[30] <= 32'h00000000;
        array_reg[31] <= 32'h00000000;
        end
        else if(ena & use_jal)
          array_reg[31] <= w_R31;
       
          // do I consider when  we is 1
        else if (ena & we & waddr != 5'b00000)
            array_reg[waddr] <= wdata;

        end
    assign reg_31 = array_reg[31];
endmodule
