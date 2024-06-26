module sci_intr (pc_addr,inst); // inst mem (rom)
input [31:0] pc_addr;
output [31:0] inst;
reg [31: 0] instr_memo [0:48];
wire [31:0] instr_addr = pc_addr >> 2;
initial begin
$readmemb("C:/Users/Nguyen Loc/Documents/cpu/instr_list.txt",instr_memo);
end
assign inst = instr_memo[instr_addr]; 
endmodule