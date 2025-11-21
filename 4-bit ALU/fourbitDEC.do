vlib work
vdel -all
vlib work

vlog fourbitDEC.sv +acc
vlog tb_fourbitDEC.sv +acc

vsim work.tb_fourbitDEC
add wave -r *
run -all