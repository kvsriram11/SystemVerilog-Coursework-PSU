package fp_pkg;

localparam int EXPONENT_BITS = 8;
localparam int FRACTION_BITS = 23;
localparam int FLOAT_BITS    = 1 + EXPONENT_BITS + FRACTION_BITS;  

typedef struct packed {
bit sign;
bit [EXPONENT_BITS-1:0] exp;
bit [FRACTION_BITS-1:0] frac;
} float;

function automatic float fpnumberfromcomponents (
input bit sign,
input bit [EXPONENT_BITS-1:0] exp,
input bit [FRACTION_BITS-1:0] frac
);

float f;
begin
f.sign = sign;
f.exp  = exp;
f.frac = frac;
return f;
end
endfunction 

function automatic float fpnumberfromshortreal (input shortreal sr);
logic [FLOAT_BITS-1:0] bits;
float f;
begin
bits = $shortrealtobits(sr); 
f    = bits;  
return f;
end
endfunction

function automatic shortreal shortrealfromfpnumber (input float f);
logic [FLOAT_BITS-1:0] bits;
begin
bits = f; 
return $bitstoshortreal(bits);
end
endfunction

function automatic void printfp (input float f);
shortreal sr;
begin
sr = shortrealfromfpnumber(f);
$display("fp: sign=%0b exp=0x%0h frac=0x%0h  (value=%f)", f.sign, f.exp, f.frac, sr);
end
endfunction

endpackage
