`include "fp_pkg.sv"
import fp_pkg::*;

module fp_alignment_tb;
float bign, smalln;
float     aligned;

int       r1, r2;
shortreal x, y;
fp_alignment dut (.bign   (bign),.smalln (smalln),.aligned(aligned));

task run_test (shortreal big_val, shortreal small_val);
float fb, fs;
shortreal aligned_val;
int shift_amt;

begin

bign   = fpnumberfromshortreal(big_val);
smalln = fpnumberfromshortreal(small_val);
#1;

fb = bign;
fs = smalln;
shift_amt   = fb.exp - fs.exp;
aligned_val = shortrealfromfpnumber(aligned);

$display("bign   = %f", big_val);
$display("smalln = %f", small_val);
$display("bign.exp   = 0x%0h", fb.exp);
$display("smalln.exp = 0x%0h", fs.exp);
$display("shift_amt  = %0d",  shift_amt);
$display("bign:");
printfp(fb);
$display("smalln:");
printfp(fs);
$display("aligned:");
printfp(aligned);
$display("shortreal aligned= %f", aligned_val);

if (aligned.exp == fb.exp) begin
$display("CHECK: aligned.exp == bign.exp: PASS");
end
else begin
$display("CHECK: aligned.exp == bign.exp: FAIL");
end
$display("");
end
endtask

initial begin
run_test(4.0, 2.0);
run_test(8.0, 1.0);
run_test(16.0, 0.5);
run_test(100.0, 0.001);
run_test(8.0, -1.0);

repeat (10) begin
float fa, fb;
r1 = $random;
r2 = $random;
x = shortreal'(r1);
y = shortreal'(r2);

fa = fpnumberfromshortreal(x);
fb = fpnumberfromshortreal(y);

if (fa.exp >= fb.exp)
run_test(x, y);
else
run_test(y, x);
end
#5;
$finish;
end
endmodule
