vlib work
vdel -all
vlib work

vlog onebitFA.sv
vlog fourbitFA.sv +acc
vlog tb_fourbitFA.sv +acc

vsim work.tb_fourbitFA
add wave -r *
run -all