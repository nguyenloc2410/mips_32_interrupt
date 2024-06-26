module sc_interrupt (clk,clrn,inst,pc,aluout,memout,memclk,intr,int_ack,vec);
input clk, clrn; // clock and reset
input memclk; // synch ram clock
input [7:0] intr; // interrupt request
output [31:0] pc; // program counter
output [31:0] inst; // instruction
output [31:0] aluout; // alu output
output [31:0] memout; // data memory output
output [2:0] vec;
output int_ack;
wire [31:0] data; // data to data memory
wire wmem; // write data memory
wire intr_req, inta;
assign int_ack = inta;
priority_en pe(intr, inta, intr_req, vec);
sccpu_intr cpu (clk,clrn,inst,memout,pc,wmem,aluout,data,intr_req,inta);
sci_intr im (pc,inst); // inst memory
scd_intr dm (memout,data,aluout,wmem,memclk); // data memory
endmodule