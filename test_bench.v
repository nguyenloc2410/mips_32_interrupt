`timescale 1ns / 1ps
module test_bench;
//input
reg clk, mem_clk;
reg [7:0] intr;
reg reset;
wire [31:0] inst, pc, aluout, memout;
wire inta;
wire [2:0] vec;
//output

sc_interrupt uut(clk,reset,inst,pc,aluout,memout,mem_clk,intr,inta,vec);
initial begin
   clk = 1;
	mem_clk = 0;
	reset = 0;
end
initial begin 
 forever begin
 #5 clk = ~clk;
 end
end
initial begin 
 forever begin
 #1.25 mem_clk = ~mem_clk;
 end
end
initial begin
intr = 8'd0;
#2
reset = 1;
#473
intr = 8'b11111111;
#20
intr = 8'd0;
end
endmodule