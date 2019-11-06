`timescale 1ns / 1ps

module sccomp_dataflow(
input clk_in,
input reset,
output [31:0] inst,
output [31:0] pc
);
  wire DM_R, DM_W, DM_CS;
  wire [31:0] dm_in, dm_out,addr;

  wire [31:0]isaddr = pc - 32'h0040_0000;
  
  dist_mem_gen_0 im(isaddr[31:2], inst);
  cpu sccpu(clk_in, reset, inst, pc, dm_out,addr,DM_CS, DM_R, DM_W,dm_in);
  dmem mydm(clk_in, reset, DM_CS, DM_R, DM_W, addr, dm_in, dm_out);

endmodule
