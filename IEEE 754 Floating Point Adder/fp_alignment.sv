`include "fp_pkg.sv"
import fp_pkg::*;

module fp_alignment (
input  float bign,
input  float smalln,
output float aligned
);

int unsigned shift_amt;
logic [FRACTION_BITS:0] sig_small;
logic [FRACTION_BITS:0] sig_aligned;

always_comb begin
shift_amt = bign.exp - smalln.exp;

sig_small = {1'b1, smalln.frac};
if (shift_amt >= (FRACTION_BITS + 1)) begin
sig_aligned = '0;
end
else begin
sig_aligned = sig_small >> shift_amt;
end
aligned.sign = smalln.sign;
aligned.exp  = bign.exp;
aligned.frac = sig_aligned[FRACTION_BITS-1:0];
end
endmodule
