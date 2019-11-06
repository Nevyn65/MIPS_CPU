`timescale 1ns / 1ps


//module cpu(clk,reset,inst,rdata1, rdata2, pc, addr,wdata,IM_R,DM_CS,DM_R,DM_W);
module cpu(clk, rst, inst, pc_out, dm_out,addr, DM_CS, DM_R, DM_W, dm_in);
  input clk;
  input rst;
  input [31:0] inst;
  input [31:0]dm_out;

  output DM_CS, DM_R, DM_W;
  output [31:0] pc_out, addr, dm_in;
  //output [4:0] Rs, Rt, Rw;
  //output IM_R, DM_CS, DM_R, DM_W;


  wire[5:0] op;
  wire [4:0] Rd, Rt, Rs, Rw;
  wire[5:0] func = inst[5:0];
  //wire [4:0] Rd;
  wire [15:0] imm16;
  wire [31:0] imm32a,imm32b;  
  wire write_reg, rf_we, mux2, mux3, mux4, mux5;
  wire [1:0] mux1;
  wire [31:0] alu_a, alu_b, wdata, shamt, alu_result,
              w_R31, reg_31,rdata1, rdata2,
              pc_in, pc_out, pc_concat, pc_add;
  wire [3:0] aluc;          
  wire zero, carry, negative, overflow,s_ext;
  assign op = inst[31:26];
  assign Rs = inst[25:21];
  assign Rt = inst[20:16];
  assign Rd = inst[15:11];
  assign shamt = {27'b0, inst[10:6]}; 
  assign imm16 = inst[15:0];

  PC mypc(clk, rst, pc_in, pc_out);
  sccu mycu(op, func, zero, write_reg, DM_CS, DM_W, DM_R, rf_we, mux1, mux2, mux3, mux4, mux5, aluc, s_ext);
  MUX5_21 mux_regdst(Rt, Rd, write_reg, Rw);
  assign w_R31 = pc_out + 4;
  wire [31:0] immediate = {imm16,inst[15:0]};
  regfile cpu_ref(clk, rst, 'b1, rf_we, mux5, w_R31, DM_W, Rs, Rt, Rw, wdata, dm_in, rdata1, rdata2, reg_31);
  alu myalu(alu_a, alu_b, aluc, alu_result, zero, carry, negative, overflow);
  MUX21 mux_a(rdata1, shamt, mux3, alu_a);
  assign addr = alu_result;
  EXT_16 imm_ext_16(s_ext, imm16, imm32a);
  MUX21 mux_b(rdata2, imm32a, mux4, alu_b);
  MUX21 mux_dm_to_rf(alu_result, dm_out, mux2, wdata);
  EXT_18 imm_ext_18(s_ext, imm16, imm32b);
  ADD beq_add(imm32b, pc_out+4, pc_add);
  assign pc_concat = {pc_out[31:28], inst[25:0], 2'b0};
  MUX41 mux_pc(pc_out +4, pc_add, rdata1, pc_concat, mux1, pc_in);

endmodule
