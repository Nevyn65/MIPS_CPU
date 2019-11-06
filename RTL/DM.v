module dmem (
    input clk,  // Clock signal. Input at negedge.
    input rst,  // HI to reset.
    input ena,  // HI to run, else output z.
    input DM_R,
    input DM_W, //
    input [31:0] addr,      // Address. ???31 or 10
    input [31:0] data_in,  // Data input at every posedge.
    output [31:0] data_out // Data output.
);
 integer i;
    reg [31:0] rom[0:2047];
    wire [31:0]isaddr;
    assign  isaddr = addr - 32'h10010000;
    assign data_out = (ena & DM_R) ? rom[isaddr[31:2]] : 32'hzzzzzzzz;
    always @ (posedge clk or posedge rst)
    begin
        if(rst)               
        for(i=0;i<2048;i=i+1)
        begin
         rom[i] = 32'h00000000;
        end
    end
    always @(posedge clk)
                          
        if (ena && DM_W == 1'b1)
            rom[isaddr[31:2]] <= data_in;
            

endmodule
