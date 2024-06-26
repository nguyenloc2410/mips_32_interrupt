# MIPS Exceptions and Interrupts Handling
# 1. MIPS with Exceptions and Interrupts Handling  Diagram

<div align="center">
<img src="/image/cpu_circuit.png">
</div>

# 2. Approach <br/>
In this project, we going to separate each block of MIPS Processor and implement it as well. So each specific block is listed as follows: <br/>
* Program Counter (PC)<br/>
* Instruction Memory <br/>
* Register File <br/>
* ALU <br/>
* Data Memory <br/>

And the block controls all these blocks unit above called Control Unit (CU), I think this block is the most important than others.

  # 3. Contraints <br/>
 1. There is only one external asynchronous interrupt request.
 2. The CPU deals with only three exceptions: arithmetic signed overflow, unimplemented instruction, and systemcall.
 3. For exceptions,the address of the current instruction that generates the exception is saved to EPC;for
 interrupt,the address of the next instruction is saved to EPC.
 4. The polled interrupt is adopted.The entry address of the interrupt/exceptionhandler is 0x00000008.
 5. Inresponse to an interrupt or anexception, the content of the Status register is shifted to the left 4 bits in order to save previous settings of the Status register and disable further interrupts.
 6.When returning from the interrupt/exceptionhandler, the content of the Status register is shifted to the right by 4bits in order to restore the previous settings of the Status register.

# 4. Registers related to exceptions and interrupts
<div align="center">
<img src="/image/registers.png">
</div>

Cause register used for detecting what kind of exceptions and interrupts<br/>
Status register used for warning to other I/O. It says "hey i am in trouble OK ?, so dont bother me ?"<br/>
EPC register used for storing the current PC orthe next PC only for the interrupt.<br/>
# 5. Instruction Memory 
 0:0800001d;% (00) j start #entryonreset <br/>
 1:00000000;% (04) nop # <br/>
 % exc_base: #exceptionhandler <br/>
 2:401a6800;% (08) mfc0$26,c0_cause #readcp0causereg %<br/>
 3:335b000c;% (0c) andi$27,$26,0xc #getexccode,2bitshere %<br/>
 4:8f7b0020;% (10) lw $27,j_table($27)#getaddressfromtable %<br/>
 5:00000000;% (14) nop # %<br/>
 6:03600008;% (18) jr $27 #jumptothataddress %<br/>
 7:00000000;% (1c) nop # %<br/>
 % int_entry: #0.interrupthandler %<br/>
 c:00000000;% (30) nop #dealwithinterrupthere %<br/>
 d:42000018;% (34) eret #returnfrominterrupt %<br/>
 e:00000000;% (38) nop # %<br/>
 % sys_entry: #1.syscallhandler %<br/>
 f:00000000;% (3c) nop #dosomethinghere %<br/>
 % epc_plus4: # %<br/>
 10:401a7000;%(40) mfc0 $26,c0_epc #getepc %<br/>
 11:235a0004;%(44) addi $26,$26, 4 #epc+4 %<br/>
 12:409a7000;%(48) mtc0 $26,c0_epc #epc<-epc+4 %<br/>
 13:42000018;%(4c) eret #returnfromexception %<br/>
 14:00000000;%(50) nop # %<br/>
 % uni_entry: #2.unimpl.inst.handler %<br/>
 15:00000000;%(54) nop #dosomethinghere %<br/>
 16:08000010;%(58) j epc_plus4 #return %<br/>
 17:00000000;%(5c) nop # %<br/>
  % ovf_entry: #3.overflowhandler %<br/>
 1a:00000000;%(68) nop #dosomethinghere %<br/>
 1b:08000010;%(6c) j epc_plus4 #return %<br/>
 1c:00000000;%(70) nop # %<br/>
 % start: # %<br/>
 1d:2008000f;%(74) addi$8,$0,0xf #im[3:0]<-1111 %<br/>
 1e:40886000;%(78) mtc0$8,c0_status #exc/intrenable %<br/>
 1f:8c080048;%(7c) lw $8,0x48($0) #tryoverflowexception %<br/>
 20:8c09004c;%(80) lw $9,0x4c($0) #causedbyadd %<br/>
 % ov: # %<br/>
 21:01094020;%(84) add $9,$9,$8 #overflow %<br/>
 22:00000000;%(88) nop # %<br/>
 % sys: # %
 23:0000000c;%(8c) syscall #systemcall %<br/>
 24:00000000;%(90) nop # %<br/>
 % unimpl: # %
 25:0128001a;%(94) div $9,$8 #div,butnotimplemented %<br/>
 26:00000000;%(98) nop # %<br/>
 % int: # %
 27:34040050;%(9c) ori $4,$1,0x50 #addressofdata[0] %<br/>
 28:20050004;%(a0) addi$5,$0, 4 #counter %<br/>
 29:00004020;%(a4) add $8,$0,$0 #sum<-0 %<br/>
 % loop: # %<br/>
 2a:8c890000;%(a8) lw $9,0($4) #loaddata %<br/>
 2b:20840004;%(ac) addi$4,$4, 4 #address+4 %<br/>
 2c:01094020;%(b0) add $8,$8,$9 #sum %<br/>
 2d:20a5ffff;%(b4) addi$5,$5,-1 #counter-1 %<br/>
 2e:14a0fffb;%(b8) bne $5,$0,loop #finish? %<br/>
 2f:00000000;%(bc) nop # %<br/>
 % finish: # %<br/>
 30:08000030;%(c0) j finish #deadloop %<br/>
 END;<br/>


If you confuse about the routine of exception or interrupt, you makeit by yourself easily whatever you want.
# 6. RTL Viewer
<div align="center">
<img src="/image/5.jpg">
<img src="/image/6.jpg">
<img src="/image/7.jpg">
</div>

# 7. Simulation
<div align="center">
<img src="/image/8.jpg">
</div>
At PC_current equal to 0 the first Instruction decoded and excute as you can see. So let check in Register File to see if it load the data or not ? 
<div align="center">
<img src="/image/9.jpg">
</div>
OKAY So it seem working !!!
