package alu_pkg;

typedef enum logic [2:0]{
OP_ADD = 3'b000,
OP_SUB = 3'b001,
OP_MUL = 3'b010,
OP_AND = 3'b011,
OP_DEC = 3'b100
} alu_op_e;
endpackage