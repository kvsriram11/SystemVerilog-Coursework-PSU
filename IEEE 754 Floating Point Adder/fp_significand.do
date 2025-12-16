vlib work
vdel -all
vlib work

vlog fp_pkg.sv
vlog fp_sorter.sv
vlog fp_sum_significands.sv +acc
vlog fp_sum_significands_tb.sv +acc

vsim work.fp_sum_significands_tb
add wave -r *
run -all