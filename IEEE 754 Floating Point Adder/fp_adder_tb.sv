
`include "fp_pkg.sv"
import fp_pkg::*;

module fp_adder_tb;

float a;
float b;
float result_fp;


shortreal A_sr, B_sr;
shortreal result_sr, expected_sum, expected_diff;

int pass_count = 0;
int fail_count = 0;
int ai;
int bi;

fp_adder dut (.a(a),.b(b),.result(result_fp));

task automatic run_test(input shortreal A_in, input shortreal B_in);
begin
A_sr = A_in;
B_sr = B_in;

a = fpnumberfromshortreal(A_sr);
b = fpnumberfromshortreal(B_sr);
#1;

result_sr = shortrealfromfpnumber(result_fp);
expected_sum = A_sr + B_sr;
expected_diff = A_sr - B_sr;

$display(" a= %0f b= %0f", A_sr, B_sr);
printfp(result_fp);
$display("DUT shortreal = %0f", result_sr);
$display("Expected SUM = %0f", expected_sum);
$display("Expected DIFF = %0f", expected_diff);

if (result_sr == expected_sum) begin
$display("PASS (SUM matched)\n");
pass_count++;
end
else begin
$display("FAIL (SUM mismatch)\n");
fail_count++;
end
end
endtask

initial begin
run_test(3.5, 1.5);
run_test(-4.0, -2.0);
run_test(5.0, -1.0);
run_test(-10.0, 3.0);
run_test(1.0, -1.0);
run_test(0.0, 123.5);
run_test(-55.0,0.0);
run_test(0.5,0.25);
run_test(-7.5, 2.25);

for (int i = 0; i < 10; i++) begin
ai = $random % 201;
bi = $random % 201;

if (ai < 0) ai = -ai;
if (bi < 0) bi = -bi;

ai = ai - 100; 
bi = bi - 100;
run_test(ai, bi);
end
$display("PASSED = %0d, FAILED = %0d",pass_count, fail_count);
$finish;
end
endmodule

/*`include "fp_pkg.sv"

module fp_adder_tb;

  import fp_pkg::*;

  // DUT connections
  float a;
  float b;
  float result_fp;

  // For checking
  shortreal A_sr, B_sr;
  shortreal result_sr, expected;

  int pass_count = 0;
  int fail_count = 0;
int raw_a;
      int raw_b;


      int tmp_a;
      int tmp_b;

      int a_int;
      int b_int;

      shortreal A_rand;
      shortreal B_rand;

  fp_adder dut (.a      (a),
    .b      (b),
    .result (result_fp)
  );

  // Simple test task
  task automatic run_test(input shortreal A_in, input shortreal B_in, input string name);
  begin
    A_sr = A_in;
    B_sr = B_in;

    // Convert to internal float type
    a = fpnumberfromshortreal(A_sr);
    b = fpnumberfromshortreal(B_sr);

    // Allow combinational logic to settle
    #1;

    // Convert DUT result back
    result_sr = shortrealfromfpnumber(result_fp);
    expected  = A_sr + B_sr;

    $display("===============================================");
    $display("%s:  A = %0f   B = %0f", name, A_sr, B_sr);
    $display("----- DUT Output -----");
    printfp(result_fp);
    $display("DUT shortreal      = %0f", result_sr);
    $display("Expected shortreal = %0f", expected);

    if (result_sr == expected) begin
      $display("** PASS **\n");
      pass_count++;
    end
    else begin
      $display("** FAIL **\n");
      fail_count++;
    end
  end
  endtask

  initial begin
    $display("========== SIMPLE FP ADDER TESTBENCH ==========");

    // ---- Directed tests with exactly representable values ----
    run_test(3.5,    1.5,    "Test 1");
    run_test(-4.0,   -2.0,   "Test 2");
    run_test(5.0,    -1.0,   "Test 3");
    run_test(-10.0,  3.0,    "Test 4");
    run_test(1.0,    -1.0,   "Test 5");
    run_test(0.0,    123.5,  "Test 6");
    run_test(-55.0,  0.0,    "Test 7");
    run_test(0.5,    0.25,   "Test 8");
    run_test(-7.5,   2.25,   "Test 9");

    // ---- Small-range random tests using simple $random ----
    // Integers in [-1000, 1000] -> exactly representable in binary32
    for (int i = 0; i < 10; i++) begin
     raw_a = $random;
     raw_b = $random;

      // Constrain to [0, 2000]
  tmp_a = raw_a % 2001;
     tmp_b = raw_b % 2001;

      // Make non-negative if modulo gave negative
      if (tmp_a < 0) tmp_a = -tmp_a;
      if (tmp_b < 0) tmp_b = -tmp_b;

      // Shift to [-1000, 1000]
     a_int = tmp_a - 1000;
     b_int = tmp_b - 1000;

   A_rand = a_int;
    B_rand = b_int;

      run_test(A_rand, B_rand, $sformatf("Random Test %0d", i+1));
    end

    $display("=================================================");
    $display("Testbench completed: PASSED = %0d, FAILED = %0d",
             pass_count, fail_count);
    $display("=================================================\n");

    $finish;
  end

endmodule*/

/*`include "fp_pkg.sv"
import fp_pkg::*;

module fp_adder_tb;
float a_fp, b_fp;
float res_fp;
shortreal a_sr, b_sr;
shortreal dut_sr, exp_sr, diff_sr;
int pass_count = 0;
int fail_count = 0;

shortreal EPS = 1.0e-4;

fp_adder dut (.a(a_fp),.b(b_fp),.result(res_fp));


task run_test(shortreal A, shortreal B);
begin
a_sr = A;
b_sr = B;

a_fp = fpnumberfromshortreal(a_sr);
b_fp = fpnumberfromshortreal(b_sr);
#1;

dut_sr = shortrealfromfpnumber(res_fp);
exp_sr = a_sr + b_sr;

diff_sr = exp_sr - dut_sr;
if (diff_sr < 0.0) diff_sr = -diff_sr;

$display("A = %f   B = %f", a_sr, b_sr);
printfp(res_fp);
$display("DUT shortreal = %f", dut_sr);
$display("Expected shortreal = %f", exp_sr);
$display("Difference = %e", diff_sr);

if (diff_sr < EPS || (dut_sr == 0.0 && exp_sr == 0.0)) begin
$display("PASS");
pass_count++;
end else begin
$display("FAIL");
fail_count++;
end
$display("");
end
	
$display("Expected SUM (A+B) = %f", exp_sr);

if (dut_sr == exp_sr || diff_sr < EPS) begin
$display("PASS");
pass_count++;
end else begin
$display("FAIL  (DUT=%f  Expected=%f)", dut_sr, exp_sr);
fail_count++;
end
endtask


function automatic shortreal rand_sr;
int r;
begin
r = $random;
rand_sr = (shortreal'(r % 200)) - 100.0;
end
endfunction

initial begin
$display("");


run_test(3.5, 1.5);
run_test(-4.0, -2.0);
run_test(5.0, -1.0);
run_test(-10.0, 3.0);
run_test(1.0, -1.0);


for (int i = 0; i < 10; i++) begin
run_test(rand_sr(), rand_sr());
end
$display("Testbench Summary: PASS = %0d, FAIL = %0d",pass_count, fail_count);
$finish;
end
endmodule*/

