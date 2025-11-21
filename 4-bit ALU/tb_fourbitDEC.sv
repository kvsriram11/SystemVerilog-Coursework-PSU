module tb_fourbitDEC;

logic [1:0] a;
wire [3:0] y;

logic [3:0] exp_y;

fourbitDEC OG (.a(a),.y(y));

initial
begin

for (int i=0; i<4;i++) begin
a = i[1:0];
#1;

exp_y= 4'b0001 << i;


if(y!=exp_y)
$display("Error: a=%b Expected y=%b Got y=%b",a,exp_y,y);


$display("a=%b Expected y=%b Got y=%b %s",a,exp_y,y,(y===exp_y) ? "PASS" : "FAIL");
end
$finish;
end
endmodule