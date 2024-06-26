module scd_intr (dataout,datain,addr,we,memclk); // data mem (sram)
input memclk; // clock
input we; // write enable
input [31:0] datain; // data in (to memory)
input [31:0] addr; // ram address
output reg [31:0] dataout; // data out (from memory)
reg [31:0] ram [0:31]; // ram cells: 32 words * 32 bits
always @ (posedge memclk)begin
if (we) ram[addr[6:2]] = datain; // use word address to write ram
dataout = ram[addr[6:2]];
end
integer i;
initial begin // initialize memory
for (i = 0; i < 32; i = i + 1) ram[i] = 0;
// ram[word_addr] = data // (byte_addr) item in data array
ram[5'h8]  = 32'h00000030; // (50) data[0] 0 + A3 = A3
ram[5'h9]  = 32'h0000003c; // (50) data[0] 0 + A3 = A3
ram[5'ha]  = 32'h00000054; // (50) data[0] 0 + A3 = A3
ram[5'hb]  = 32'h00000068; // (50) data[0] 0 + A3 = A3
ram[5'h12] = 32'h00000002; // (50) data[0] 0 + A3 = A3
ram[5'h13] = 32'h7fffffff; // (54) data[1] a3 + 27 = ca
ram[5'h14] = 32'h000000a3; // (58) data[2] ca + 79 = 143
ram[5'h15] = 32'h00000027; // (5c) data[3] 143 + 115 = 258
ram[5'h16] = 32'h00000079; // (5c) data[3] 143 + 115 = 258
ram[5'h17] = 32'h00000115; // (5c) data[3] 143 + 115 = 258
end
endmodule