module IM (
    input [31:0] addr, // Address.
    output [31:0] data_out // Data output.
);
    reg [31:0] rom[0:1023];
    // automaticly Initialize, instead of wri
      initial begin
    $readmemh ("C:/Users/sillybbbbb/Desktop/cpu/hex/addiu.txt", rom);
    end
    wire [31:0] offset_addr = addr - 32'h0040_0000;
    assign data_out = rom[offset_addr[12:2]];
endmodule
