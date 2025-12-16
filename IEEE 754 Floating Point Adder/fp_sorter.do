vlib work
vdel -all
vlib work

vlog fp_pkg.sv
vlog fp_sorter.sv +acc
vlog fp_sorter_tb.sv +acc

vsim work.fp_sorter_tb
add wave -r *
run -all