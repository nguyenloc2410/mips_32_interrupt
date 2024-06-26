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

  # 3. Contraint <br/>
 1. Thereisonlyoneexternalasynchronousinterruptrequest.
 2. TheCPUdealswithonlythreeexceptions:arithmeticsignedoverflow,unimplementedinstruction,
 andsystemcall.
 3. Forexceptions,theaddressofthecurrentinstructionthatgeneratestheexceptionissavedtoEPC;for
 interrupt,theaddressofthenextinstructionissavedtoEPC.
 4. Thepolledinterruptisadopted.Theentryaddressoftheinterrupt/exceptionhandleris0x00000008.
 5. Inresponsetoaninterruptoranexception, thecontentoftheStatusregisterisshiftedtotheleftby
 4bitsinordertosaveprevioussettingsoftheStatusregisteranddisablefurtherinterrupts.
 6.Whenreturningfromtheinterrupt/exceptionhandler, thecontentoftheStatusregisterisshiftedto
 therightby4bitsinordertorestoretheprevioussettingsoftheStatusregister.

# 4. Instructions Structure
4.1 R-Type
<div align="center">
<img src="/image/3.png">
</div>
4.2 I-Type
<div align="center">
<img src="/image/2.png">
</div>
4.3 Jump
<div align="center">
<img src="/image/4.png">
</div>

# 5. Instruction Memory 
* 0000010000000000 load R0 <- Mem(R2 + 0)
* 0000010001000001 load R1 <- Mem(R2 + 1)
* 0010000001010000 Add R2 <- R0 + R1
* 0001001010000000 Store Mem(R1 + 0) <- R2
* 0011000001010000 sub R2 <- R0 - R1
* 0100000001010000 invert R2 <- !R0 
* 0101000001010000 logical shift left R2 <- R0<<R1 
* 0110000001010000 logical shift right R2 <- R0>>R1 
* 0111000001010000 AND R2<- R0 AND R1 
* 1000000001010000 OR R2<- R0 OR R1 
* 1001000001010000 SLT R2 <- 1 if R0 < R1 
* 0010000000000000 Add R0 <- R0 + R0
* 1011000001000001 BEQ branch to jump if R0=R1, PCnew= PC+2+offset<<1 = 28 => offset = 1
* 1100000001000000 BNE branch to jump if R0!=R1, PCnew= PC+2+offset<<1 = 28 => offset = 0
* 1101000000000000 J jump to the beginning address

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
