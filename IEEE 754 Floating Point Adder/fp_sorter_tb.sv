`include "fp_pkg.sv"
import fp_pkg::*;

module fp_sorter_tb;

float a, b;   
float bign, smalln;  

fp_sorter dut (.a(a),.b(b), .bign(bign), .smalln(smalln));

task run_test (shortreal x, shortreal y);
begin
a = fpnumberfromshortreal(x);
b = fpnumberfromshortreal(y);
#1;
$display("a = %f,  b= %f", x, y);
$display("float a");
printfp(a);
$display("float b");
printfp(b);
$display("sorted");
printfp(bign);
printfp(smalln);
$display("shortreal bign  = %f", shortrealfromfpnumber(bign));
$display("shortreal smalln = %f", shortrealfromfpnumber(smalln));
$display("");
end
endtask

initial begin
int i;
int signed rx, ry;
shortreal x, y;

run_test(3.5,-10.0);
run_test(4.0,-4.0);
run_test(0.0,5.0);
run_test(-2.0,-50.0);
run_test(1.5,0.125);
run_test(7.25,7.25);

for (i = 0; i < 20; i++) begin
rx = $urandom_range(-1000, 1000);
ry = $urandom_range(-1000, 1000);

x = shortreal'(rx) / 8.0;
y = shortreal'(ry) / 8.0;

run_test(x, y);
end

#5;
$finish;
end
endmodule
