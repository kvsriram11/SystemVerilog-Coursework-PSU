vlib work
vdel -all
vlib work

vlog fp_pkg.sv
vlog fp_sorter.sv
vlog fp_alignment.sv
vlog fp_sum_significands.sv
vlog fp_adder.sv +acc
vlog fp_adder_tb.sv +acc

vsim work.fp_adder_tb
add wave -r *
run -all