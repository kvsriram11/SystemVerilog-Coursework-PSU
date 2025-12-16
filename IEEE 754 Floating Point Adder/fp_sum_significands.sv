`include "fp_pkg.sv"
import fp_pkg::*;

module fp_sum_significands (
input  float bign,
input  float smalln,
output logic [FRACTION_BITS+1:0] sum 
);

logic [FRACTION_BITS:0]   sig_big;   
logic [FRACTION_BITS:0]   sig_small;  
logic [FRACTION_BITS+1:0] sum_ext;  

always_comb begin
sig_big   = {1'b1, bign.frac};
sig_small = {1'b1, smalln.frac};

if (bign.sign == smalln.sign) begin
sum_ext = sig_big + sig_small; 
end
else begin
sum_ext = sig_big - sig_small;
end
sum = sum_ext;
end

endmodule 
