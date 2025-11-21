module ha (cout,sum,a,b);
input logic a,b;
output logic cout,sum;
xor G1 (sum,a,b); 
and G2 (cout,a,b);
endmodule