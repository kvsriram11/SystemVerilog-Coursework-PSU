vlib work
vdel -all
vlib work

vlog onebitFA.sv +acc
vlog tb_onebitFA.sv +acc

vsim work.tb_onebitFA
add wave -r *
run -all