module tb_fourbitFA;

logic [3:0] a,b;
wire [3:0] sum;
wire carry;

logic [4:0] exp_result;
logic [3:0] exp_sum;
logic exp_carry;

fourbitFA OG (.a(a),.b(b),.sum(sum),.carry(carry));

initial
begin

for (int i=0; i<16;i++) begin
for (int j=0; j<16;j++) begin
a=i[3:0];
b=j[3:0];
#1;

exp_result= a+b;
exp_sum= exp_result[3:0];
exp_carry= exp_result[4];

if(sum!=exp_sum)
$display("Error: a=%b b=%b Expected sum=%b Got=%b",a,b,exp_sum,sum);

if(carry!=exp_carry)
$display("Error: a=%b b=%b Expected carry=%b Got=%b",a,b,exp_carry,carry);

$display("a=%b b=%b Expected sum=%b Got sum=%b Expected carry=%b Got carry=%b %s",a,b,exp_sum,sum,exp_carry,carry,((sum===exp_sum) && (carry===exp_carry)) ? "PASS" : "FAIL");
end
end
$finish;
end
endmodule