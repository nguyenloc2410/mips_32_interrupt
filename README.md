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
