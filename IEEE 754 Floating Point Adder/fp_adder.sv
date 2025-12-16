`include "fp_pkg.sv"
import fp_pkg::*;

module fp_adder (
input  float a,
input  float b,
output float result
);

float bign, smalln;
float res;

logic [EXPONENT_BITS-1:0] exp_big, exp_small, exp_res;
logic [EXPONENT_BITS-1:0] exp_diff;

logic [FRACTION_BITS:0]   man_big;      
logic [FRACTION_BITS:0]   man_small;
logic [FRACTION_BITS:0]   man_small_aligned;

logic [FRACTION_BITS+1:0] man_tmp;          
logic [FRACTION_BITS+1:0] man_norm;         
logic [EXPONENT_BITS-1:0] exp_norm;

bit same_sign;
bit res_sign;

int i; 

function automatic bit is_zero (input float f);
if (f.exp == '0 && f.frac == '0)
is_zero = 1'b1;
else
is_zero = 1'b0;
endfunction

fp_sorter u_sorter (.a(a),.b(b),.bign(bign),.smalln(smalln));
fp_alignment dut_align (.bign(bign),.smalln(smalln),.aligned(d_aligned));
fp_sum_significands dut_sum (.bign(bign),.smalln(smalln),.sum(dummy_sum));

always_comb begin
res.sign = 1'b0;
res.exp  = '0;
res.frac = '0;

if (is_zero(a) && is_zero(b)) begin
res.sign = a.sign & b.sign; 
res.exp  = '0;
res.frac = '0;
end
else begin
exp_big   = bign.exp;
exp_small = smalln.exp;

if (exp_big == '0)
man_big = {1'b0, bign.frac};  
else
man_big = {1'b1, bign.frac};

if (exp_small == '0)
man_small = {1'b0, smalln.frac};
else
man_small = {1'b1, smalln.frac};

if (exp_big > exp_small)
exp_diff = exp_big - exp_small;
else
exp_diff = '0;
if (exp_diff >= (FRACTION_BITS + 2))
man_small_aligned = '0;        
else
man_small_aligned = man_small >> exp_diff;
exp_res   = exp_big;
same_sign = (bign.sign == smalln.sign);
res_sign  = bign.sign;

if (same_sign) begin
man_tmp = man_big + man_small_aligned;
end
else begin
man_tmp = {1'b0, man_big} - {1'b0, man_small_aligned};
if (man_tmp == '0)
res_sign = 1'b0;
end
if (man_tmp == '0) begin
res.sign = 1'b0;
res.exp  = '0;
res.frac = '0;
end
else begin
man_norm = man_tmp;
exp_norm = exp_res;
if (man_norm[FRACTION_BITS+1]) begin
man_norm = man_norm >> 1;
exp_norm = exp_norm + 1'b1;
end
else begin
for (i = 0; i < (FRACTION_BITS+2); i++) begin
if (man_norm[FRACTION_BITS] || (exp_norm == 0))
break;
man_norm = man_norm << 1;
exp_norm = exp_norm - 1'b1;
end
end
res.sign = res_sign;
res.exp  = exp_norm;
res.frac = man_norm[FRACTION_BITS-1:0];
end
end
result = res;
end
endmodule
