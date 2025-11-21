module tb_onebitFA;

logic a,b,cin;
wire sum, carry;
logic exp_sum, exp_carry;

onebitFA OG (.a(a),.b(b),.cin(cin),.sum(sum),.carry(carry));

initial
begin

for (int i=0; i<8;i++) begin
{a,b,cin} = i[2:0];
#1;

exp_sum= a^b^cin;
exp_carry= ((a&b) | (b&cin) | (cin&a));

if(sum!=exp_sum)
$display("Error: a=%b b=%b cin=%b Expected sum=%b Got=%b",a,b,cin,exp_sum,sum);

if(carry!=exp_carry)
$display("Error: a=%b b=%b cin=%b Expected carry=%b Got=%b",a,b,cin,exp_carry,carry);

$display("a=%b b=%b cin=%b Expected sum=%b Got sum=%b Expected carry=%b Got carry=%b %s",a,b,cin,exp_sum,sum,exp_carry,carry,((sum===exp_sum) && (carry===exp_carry)) ? "PASS" : "FAIL");
end
$finish;
end
endmodule