#!/usr/bin/tclsh
set DOT_PRODUCT_GENERIC_ROOT "../"
quit -sim

exec vlib work

# exec vmap gpgpu work

set dot_product_files_vhdls [list \
	"## Package" \
	"$DOT_PRODUCT_GENERIC_ROOT/DPU_adder_tree_pipeline/def_package.vhd" \
	"$DOT_PRODUCT_GENERIC_ROOT/DPU_adder_tree_pipeline/FPAdd_3_pipe.vhd" \
	"$DOT_PRODUCT_GENERIC_ROOT/DPU_adder_tree_pipeline/FPMult_3_pipe.vhd" \
	"$DOT_PRODUCT_GENERIC_ROOT/DPU_adder_tree_pipeline/dot_unit_core.vhd" \
	"$DOT_PRODUCT_GENERIC_ROOT/DPU_adder_tree_pipeline/sub_tensor_core_flat.vhd" \
	"# TB - Top-level" \
	"$DOT_PRODUCT_GENERIC_ROOT/TB_pipeline/TC_tb_flat.vhd" \
]

foreach src $dot_product_files_vhdls {
	if [expr {[string first # $src] eq 0}] {puts $src} else {
		#exec >@stdout 2>@stderr
		vcom -64 -2008 -work work $src
	}
}

vsim -64 -voptargs=+acc work.TC_core_TB
#vsim -voptargs=+acc work.tb_top_level



vcd add -file FP_TC.vcd -ports TC_core_TB/TCU0/*



#do wave.do


run 5000 ns

#run -all


