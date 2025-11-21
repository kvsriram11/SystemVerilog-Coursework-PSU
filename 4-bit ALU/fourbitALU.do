vlib work
vdel -all
vlib work

vlog alu_pkg.sv

vlog ha.sv
vlog fa.sv
vlog four.sv
vlog five.sv
vlog onebitFA.sv
vlog fourbitFA.sv
vlog fourbitMUL.sv
vlog fourbitDEC.sv
vlog fourbitALU.sv +acc
vlog tb_fourbitALU.sv +acc

vsim work.tb_fourbitALU
add wave -r *
run -all