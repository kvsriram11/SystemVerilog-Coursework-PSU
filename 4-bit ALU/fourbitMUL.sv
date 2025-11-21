module fourbitMUL(
input logic [3:0] a,b,
output logic [7:0] product
);

wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10;

and G00 (p00,a[0],b[0]);
and G10 (p10,a[1],b[0]);
and G20 (p20,a[2],b[0]);
and G30 (p30,a[3],b[0]);
and G01 (p01,a[0],b[1]);
and G11 (p11,a[1],b[1]);
and G21 (p21,a[2],b[1]);
and G31 (p31,a[3],b[1]);
and G02 (p02,a[0],b[2]);
and G12 (p12,a[1],b[2]);
and G22 (p22,a[2],b[2]);
and G32 (p32,a[3],b[2]);
and G03 (p03,a[0],b[3]);
and G13 (p13,a[1],b[3]);
and G23 (p23,a[2],b[3]);
and G33 (p33,a[3],b[3]);
assign product[0]=p00;

ha Col1 (c1,product[1],p10,p01);
four Col2 (c3,c2,product[2],p20,p11,p02,c1);
five Col3 (c5,c4,product[3],p30,p21,p12,p03,c2);
five Col4 (c7,c6,product[4],p31,p22,p13,c3,c4);
four Col5 (c9,c8,product[5],p32,p23,c5,c6);
fa Col6 (c10,product[6],p33,c7,c8);
ha Col7 (unused,product[7],c9,c10);

endmodule