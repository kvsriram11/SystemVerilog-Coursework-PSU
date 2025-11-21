module five (cout1,cout0,sum,a,b,c,d,e);
input logic a,b,c,d,e;
output logic cout1,cout0,sum;

four G1 (c1,c0,s0,a,b,c,d);
ha G2 (c2,sum,s0,e);
ha G3 (c3, cout0, c0, c2);
ha G4 (unused, cout1, c1, c3);

endmodule