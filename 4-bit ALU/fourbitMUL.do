vlib work
vdel -all
vlib work

vlog ha.sv
vlog fa.sv
vlog four.sv
vlog five.sv
vlog fourbitMUL.sv +acc
vlog tb_fourbitMUL.sv +acc

vsim work.tb_fourbitMUL
add wave -r *
run -all