`include "fp_pkg.sv"
import fp_pkg::*;

module fp_sum_significands_tb;

float in_a, in_b;
float bign, smalln;

logic [FRACTION_BITS+1:0] sum;

fp_sorter dut_sorter (.a(in_a),.b(in_b),.bign(bign),.smalln(smalln));
fp_sum_significands dut_sum (.bign(bign),.smalln (smalln),.sum(sum));

task run_test (shortreal x, shortreal y);

logic [FRACTION_BITS:0] sig_big_tb, sig_small_tb;
logic [FRACTION_BITS+1:0] expected;

begin
in_a = fpnumberfromshortreal(x);
in_b = fpnumberfromshortreal(y);
#1;
sig_big_tb = {1'b1, bign.frac};
sig_small_tb = {1'b1, smalln.frac};

if (bign.sign == smalln.sign)
expected = sig_big_tb + sig_small_tb;
else
expected = sig_big_tb - sig_small_tb;

$display("x = %f, y = %f", x, y);
$display("sorting");
printfp(bign);
printfp(smalln);
$display("sig_big_tb = 0x%0h", sig_big_tb);
$display("sig_small_tb = 0x%0h", sig_small_tb);
$display("DUT sum= 0x%0h", sum);
$display("expected sum = 0x%0h", expected);

if (sum !== expected)
$display("FAIL");
else
$display("PASS");
end
endtask

int r1, r2;
shortreal x, y;

initial begin

run_test(3.5, 1.5);
run_test(-4.0, -2.0);
run_test(5.0, -1.0);
run_test(-10.0, 3.0);
run_test(1.0, -1.0);

repeat (10) begin
r1 = $random;
r2 = $random;
x  = shortreal'(r1);
y  = shortreal'(r2);
run_test(x, y);
end
#5;
$finish;
end
endmodule
