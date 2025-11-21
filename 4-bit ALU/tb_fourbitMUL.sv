module tb_fourbitMUL;

logic [3:0] a,b;
wire [7:0] product;

logic [7:0] exp_product;

fourbitMUL OG (.a(a),.b(b),.product(product));

initial
begin

for (int i=0; i<16;i++) begin
for (int j=0; j<16;j++) begin
a=i[3:0];
b=j[3:0];
#1;

exp_product= a*b;

if(product!=exp_product)
$display("Error: a=%b b=%b Expected product=%b Got=%b",a,b,exp_product,product);


$display("a=%b b=%b Expected product=%b Got product=%b %s",a,b,exp_product,product,(product===exp_product) ? "PASS" : "FAIL");
end
end
$finish;
end
endmodule