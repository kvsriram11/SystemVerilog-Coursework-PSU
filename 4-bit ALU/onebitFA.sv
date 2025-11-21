module onebitFA (
input logic a,b,cin,
output logic sum, carry
);

wire t1,t2,t3;

xor G1 (sum,a,b,cin);
and G2 (t1,a,b);
and G3 (t2,b,cin);
and G4 (t3,cin,a);
or G5 (carry,t1,t2,t3);

endmodule