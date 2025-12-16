`include "fp_pkg.sv"
import fp_pkg::*;

module fp_sorter (
input  float a,
input  float b,
output float bign,
output float smalln
);

always_comb begin

float a_abs, b_abs;

a_abs = a;
b_abs = b;

a_abs.sign = 1'b0; 
b_abs.sign = 1'b0; 

bign   = a;
smalln = b;

if (a_abs.exp > b_abs.exp) begin
bign   = a;
smalln = b;
end

else if (a_abs.exp < b_abs.exp) begin
bign   = b;
smalln = a;
end

else begin
if (a_abs.frac >= b_abs.frac) begin
bign   = a;
smalln = b;
end

else begin
bign   = b;
smalln = a;
end

end
end
endmodule
