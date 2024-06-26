module mux4x32 (a0, a1, a2, a3, s, y); // multiplexer, dataflow style
input [1:0] s;
input [31:0] a0, a1, a2, a3;
output reg [31:0] y; // output
always @(*)begin
case(s)
2'b00 : y = a0;
2'b01 : y = a1;
2'b10 : y = a2;
2'b11 : y = a3;
default : y = a0;
endcase
end
endmodule