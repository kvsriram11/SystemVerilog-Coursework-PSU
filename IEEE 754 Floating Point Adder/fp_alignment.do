vlib work
vdel -all
vlib work

vlog fp_pkg.sv
vlog fp_alignment.sv +acc
vlog fp_alignment_tb.sv +acc

vsim work.fp_alignment_tb
add wave -r *
run -all