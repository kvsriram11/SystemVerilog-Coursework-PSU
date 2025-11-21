module fourbitFA (
input logic [3:0] a,b,
output logic [3:0] sum,
output logic carry
);

logic [2:0] C;

onebitFA FA0 (.a(a[0]), .b(b[0]), .cin(1'b0), .sum(sum[0]), .carry(C[0]));
onebitFA FA1 (.a(a[1]), .b(b[1]), .cin(C[0]), .sum(sum[1]), .carry(C[1]));
onebitFA FA2 (.a(a[2]), .b(b[2]), .cin(C[1]), .sum(sum[2]), .carry(C[2]));
onebitFA FA3 (.a(a[3]), .b(b[3]), .cin(C[2]), .sum(sum[3]), .carry(carry));

endmodule