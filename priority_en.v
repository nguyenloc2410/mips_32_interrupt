module priority_en(intr, ena, intr_req, vec);
input [7:0] intr;
input ena;
output intr_req;
output reg [2:0] vec;

assign intr_req = |intr;

always @(intr, ena, vec)begin
casex({ena, intr})
9'b1_1xxxxxxx: vec = 3'd7;
9'b1_01xxxxxx: vec = 3'd6;
9'b1_001xxxxx: vec = 3'd5;
9'b1_0001xxxx: vec = 3'd4;
9'b1_00001xxx: vec = 3'd3;
9'b1_000001xx: vec = 3'd2;
9'b1_0000001x: vec = 3'd1;
default: vec = 3'd0;
endcase
end
endmodule