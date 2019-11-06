`timescale 1ns / 1ps

module sccu(op, func, zero, write_reg, DM_CS, DM_W, DM_R, rf_we, mux1, mux2, mux3, mux4, mux5, aluc, s_ext);
	input [5:0] op,func;

	input zero;
	output write_reg, DM_CS, DM_W, DM_R, rf_we, mux3, mux4, mux2, mux5;
  
  output s_ext;//s_ext indicates zero extend or signed extend
	output [3:0] aluc;
	output [1:0] mux1;
	wire r_type = ~|op;
	wire i_add = r_type & func[5] & ~func[4] & ~func[3] &
				~func[2] & ~func[1] & ~func[0];
  wire i_addu = r_type & func[5] & ~func[4] & ~func[3] &
				~func[2] & ~func[1] & func[0];
	wire i_sub = r_type & func[5] & ~func[4] & ~func[3] &
				~func[2] & func[1] & ~func[0];
  wire i_subu = r_type & func[5] & ~func[4] & ~func[3] &
      	~func[2] & func[1] & func[0];
	wire i_and = r_type & func[5] & ~func[4] & ~func[3] &
				func[2] & ~func[1] & ~func[0];
	wire i_or = r_type & func[5] & ~func[4] & ~func[3] &
				func[2] & ~func[1] & func[0];
	wire i_xor = r_type & func[5] & ~func[4] & ~func[3] &
				func[2] & func[1] & ~func[0];
  wire i_nor = r_type & func[5] & ~func[4] & ~func[3] &
        func[2] & func[1] & func[0];
  wire i_slt = r_type & func[5] & ~func[4] & func[3] &
        ~func[2] & func[1] & ~func[0];
  wire i_sltu = r_type & func[5] & ~func[4] & func[3] &
        ~func[2] & func[1] & func[0];
	wire i_sll = r_type & ~func[5] & ~func[4] & ~func[3] &
				~func[2] & ~func[1] & ~func[0];
	wire i_srl = r_type & ~func[5] & ~func[4] & ~func[3] &
				~func[2] & func[1] & ~func[0];
	wire i_sra = r_type & ~func[5] & ~func[4] & ~func[3] &
				~func[2] & func[1] & func[0];
  wire i_sllv = r_type & ~func[5] & ~func[4] & ~func[3] &
      	func[2] & ~func[1] & ~func[0];
  wire i_srlv = r_type & ~func[5] & ~func[4] & ~func[3] &
        func[2] & func[1] & ~func[0];
  wire i_srav = r_type & ~func[5] & ~func[4] & ~func[3] &
        func[2] & func[1] & func[0];
	wire i_jr = r_type & ~func[5] & ~func[4] & func[3] &
				~func[2] & ~func[1] & ~func[0];
	wire i_addi = ~op[5] & ~op[4] & op[3] & ~op[2] & ~op[1] & ~op[0];
  wire i_addiu = ~op[5] & ~op[4] & op[3] & ~op[2] & ~op[1] & op[0];
	wire i_andi = ~op[5] & ~op[4] & op[3] & op[2] & ~op[1] & ~op[0];
	wire i_ori = ~op[5] & ~op[4] & op[3] & op[2] & ~op[1] & op[0];
	wire i_xori = ~op[5] & ~op[4] & op[3] & op[2] & op[1] & ~op[0];
	wire i_lw = op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & op[0];
	wire i_sw = op[5] & ~op[4] & op[3] & ~op[2] & op[1] & op[0];
	wire i_beq = ~op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] & ~op[0];
	wire i_bne = ~op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] & op[0];


  wire i_slti = ~op[5] & ~op[4] & op[3] & ~op[2] & op[1] & ~op[0];
  wire i_sltiu = ~op[5] & ~op[4] & op[3] & ~op[2] & op[1] & op[0];
	wire i_lui = ~op[5] & ~op[4] & op[3] & op[2] & op[1] & op[0];
	wire i_j = ~op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & ~op[0];
	wire i_jal = ~op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & op[0];
	//default zero extend
	//assign s_ext[0] = i_andi | i_ori | i_xori | i_lui ;//0 extend
  assign s_ext = i_addi | i_addiu | i_lw | i_sw | i_beq | i_bne | i_slti | i_sltiu ;//sign extend
//ATTENTION	// it seems that srlv is false?????????
	assign aluc[0] = i_sub |i_subu |i_or |i_nor |i_slt |i_srl |i_srlv |i_ori |i_beq |i_bne |i_slti;//i_and | i_or |i_sll |i_srl |i_sra |i_andi |i_ori;
	assign aluc[1] = i_add |i_sub |i_xor |i_nor |i_slt |i_sltu |i_sll | i_sllv |i_addi |i_xori |i_beq |i_bne |i_slti |i_sltiu;//i_xor | i_sll |i_srl |i_sra |i_xori |i_lui;
	assign aluc[2] = i_and |i_or |i_xor |i_nor |i_sll |i_srl |i_sra |i_sllv |i_srlv |i_srav |i_andi |i_ori |i_xori;//i_sub | i_or | i_srl |i_sra | i_ori |i_beq | i_bne |i_lui;
	assign aluc[3] = i_slt |i_sltu |i_sll |i_srl |i_sra |i_sllv |i_srlv |i_srav |i_slti |i_sltiu |i_lui;//i_sra ;

	// The w object is Rd when r-type, Rt when I-type
	assign write_reg = r_type;
	//assign reg_wr = r_type | i_addi | i_andi | i_ori | i_xori | i_lw | i_jal;
	assign mux1[0] = (~zero&i_beq) | (zero&i_bne)  | i_j | i_jal ;
	assign mux1[1] = i_jr | i_j | i_jal;//beq||bne = 01;i_jr = 10;i_j||i_jal = 11; pc+4 = 00
  assign rf_we = i_add |i_addu |i_sub |i_subu |i_and |i_or |i_xor |i_nor |i_slt |i_sltu |
  				        i_sll |i_srl |i_sra |i_sllv |i_srlv |i_srav |i_addi |i_addiu |i_andi |
  				        i_ori |i_xori |i_lw |i_slti |i_sltiu |i_lui | i_jal;
	assign mux2 = i_lw;

	assign mux3 = i_sll |i_srl |i_sra;//assign aluimm = i_lui | i_addi | i_andi | i_ori | i_xori  | i_lw | i_sw;
	                                      //assign shift = i_sll | i_srl | i_sra;
	assign mux4 = i_lui |i_addi |i_addiu |i_andi |i_ori |i_xori |i_lw |i_sw |i_slti |i_sltiu;
	assign mux5 = i_jal;//1 --> RF_w

	assign DM_R = i_lw;
	assign DM_W = i_sw;
	                                      //assign call = i_jal;
	assign DM_CS = i_sw | i_lw;
  endmodule
