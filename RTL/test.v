`timescale 1ns / 1ps
// Project Name: test for cpu31

module test;
    //Inputs
   reg clk_in;
        reg reset;
        //Outputs
        wire [31:0] inst;       //instruction
        wire [31:0] pc;         //program counter
       // wire [31:0] addr;       //aluout
        //wire [31:0] rdata1, rdata2, wdata, alu_a, alu_b;
        //wire [4:0] Rs, Rt, Rw;
        //wire [3:0]aluc;
        //wire DM_W,s_ext,write_reg;
    sccomp_dataflow uut(clk_in, reset, inst, pc);

    integer file_output, count;
    initial
        begin
        //$dumpfile("lui_re.txt");
        //$dumpvars(0, test, uut.pcreg.data_out);
        file_output = $fopen("lw.txt");
        //Initialize Inputs
        count = 0;
        clk_in = 0;
        reset = 1;
        #5 reset = 0;        //wait #50 for global reset to finish
    end
    always@(*)begin
        #5 clk_in<=~clk_in;
    end
    always@(negedge clk_in)  begin
            if(!reset)
            begin
            count = count + 1'b1;
            $fdisplay(file_output, "pc: %h", test.uut.sccpu.pc_out);
            $fdisplay(file_output, "instr: %h", test.uut.sccpu.inst);

            $fdisplay(file_output, "regfile0: %h", test.uut.sccpu.cpu_ref.array_reg[0]);
            $fdisplay(file_output, "regfile1: %h", test.uut.sccpu.cpu_ref.array_reg[1]);
            $fdisplay(file_output, "regfile2: %h", test.uut.sccpu.cpu_ref.array_reg[2]);
            $fdisplay(file_output, "regfile3: %h", test.uut.sccpu.cpu_ref.array_reg[3]);
            $fdisplay(file_output, "regfile4: %h", test.uut.sccpu.cpu_ref.array_reg[4]);
            $fdisplay(file_output, "regfile5: %h", test.uut.sccpu.cpu_ref.array_reg[5]);
            $fdisplay(file_output, "regfile6: %h", test.uut.sccpu.cpu_ref.array_reg[6]);
            $fdisplay(file_output, "regfile7: %h", test.uut.sccpu.cpu_ref.array_reg[7]);
            $fdisplay(file_output, "regfile8: %h", test.uut.sccpu.cpu_ref.array_reg[8]);
            $fdisplay(file_output, "regfile9: %h", test.uut.sccpu.cpu_ref.array_reg[9]);
            $fdisplay(file_output, "regfile10: %h", test.uut.sccpu.cpu_ref.array_reg[10]);
            $fdisplay(file_output, "regfile11: %h", test.uut.sccpu.cpu_ref.array_reg[11]);
            $fdisplay(file_output, "regfile12: %h", test.uut.sccpu.cpu_ref.array_reg[12]);
            $fdisplay(file_output, "regfile13: %h", test.uut.sccpu.cpu_ref.array_reg[13]);
            $fdisplay(file_output, "regfile14: %h", test.uut.sccpu.cpu_ref.array_reg[14]);
            $fdisplay(file_output, "regfile15: %h", test.uut.sccpu.cpu_ref.array_reg[15]);
            $fdisplay(file_output, "regfile16: %h", test.uut.sccpu.cpu_ref.array_reg[16]);
            $fdisplay(file_output, "regfile17: %h", test.uut.sccpu.cpu_ref.array_reg[17]);
            $fdisplay(file_output, "regfile18: %h", test.uut.sccpu.cpu_ref.array_reg[18]);
            $fdisplay(file_output, "regfile19: %h", test.uut.sccpu.cpu_ref.array_reg[19]);
            $fdisplay(file_output, "regfile20: %h", test.uut.sccpu.cpu_ref.array_reg[20]);
            $fdisplay(file_output, "regfile21: %h", test.uut.sccpu.cpu_ref.array_reg[21]);
            $fdisplay(file_output, "regfile22: %h", test.uut.sccpu.cpu_ref.array_reg[22]);
            $fdisplay(file_output, "regfile23: %h", test.uut.sccpu.cpu_ref.array_reg[23]);
            $fdisplay(file_output, "regfile24: %h", test.uut.sccpu.cpu_ref.array_reg[24]);
            $fdisplay(file_output, "regfile25: %h", test.uut.sccpu.cpu_ref.array_reg[25]);
            $fdisplay(file_output, "regfile26: %h", test.uut.sccpu.cpu_ref.array_reg[26]);
            $fdisplay(file_output, "regfile27: %h", test.uut.sccpu.cpu_ref.array_reg[27]);
            $fdisplay(file_output, "regfile28: %h", test.uut.sccpu.cpu_ref.array_reg[28]);
            $fdisplay(file_output, "regfile29: %h", test.uut.sccpu.cpu_ref.array_reg[29]);
            $fdisplay(file_output, "regfile30: %h", test.uut.sccpu.cpu_ref.array_reg[30]);
            $fdisplay(file_output, "regfile31: %h", test.uut.sccpu.cpu_ref.array_reg[31]);
          end

       
    end

endmodule
