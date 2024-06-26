module mux2x5 (a0, a1, s, y); // multiplexer, dataflow style
input s;
input [4:0] a0, a1;
output [4:0] y; // output
assign y = s ? a1 : a0; // if (s==1) y=a1; else y=a0;
endmodule