module four (cout1, cout0,sum,a,b,c,d);
input logic a,b,c,d;
output logic cout1,cout0,sum;

fa G1 (c0,s0,a,b,c);
ha G2 (c1,sum,s0,d);
ha G3 (cout1,cout0,c0,c1);

endmodule