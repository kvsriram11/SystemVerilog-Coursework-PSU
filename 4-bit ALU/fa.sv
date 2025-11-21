module fa (cout,sum,a,b,c);
input logic a,b,c;
output logic sum, cout;

wire t1,t2,t3;

xor G1 (sum,a,b,c);
and G2 (t1,a,b);
and G3 (t2,b,c);
and G4 (t3,c,a);
or G5 (cout,t1,t2,t3);

endmodule