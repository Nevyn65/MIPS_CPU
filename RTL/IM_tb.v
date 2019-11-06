module IM_tb;
  reg [31:0] addr;
  wire [31:0] data_out;
  IM inst(addr, data_out);    
  initial begin
    addr = 32'h0040_0000;
    
        #50
    addr = 32'h0040_0008;
    
  end

endmodule
