import alu_pkg::*;

module fourbitALU (
input logic [3:0] a,b,
input alu_op_e opcode,
output logic [7:0] result
);

logic [3:0] sum;
logic carry;
logic [7:0] product;
logic [3:0] y;

fourbitFA s_add (.*);
fourbitMUL s_mul (.a(a), .b(b), .product(product));
fourbitDEC s_dec (.a(a[1:0]), .y(y));

logic [7:0] ta,ts,tb,td;

assign ta = {3'b000, carry,sum};
assign td = {4'b0000, y};

always @(a or b) begin
ts={4'b0000, (a-b)};
tb={4'b0000, (a&b)};
end

always@* begin
case (opcode)
OP_ADD : result = ta;
OP_SUB : result = ts;
OP_MUL : result = product;
OP_AND : result = tb;
OP_DEC : result = td;
default: result = 8'd0;
endcase

end

endmodule
