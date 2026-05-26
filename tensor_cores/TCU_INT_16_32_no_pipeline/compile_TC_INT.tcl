#!/usr/bin/tclsh
set DOT_PRODUCT_GENERIC_ROOT "../"
quit -sim


exec vlib work

# exec vmap gpgpu work

set dot_product_files_vhdls [list \
	"# Top-level, reference components" \
	"$DOT_PRODUCT_GENERIC_ROOT/INT_TCU/def_package.vhd" \
	"$DOT_PRODUCT_GENERIC_ROOT/INT_TCU/Adder_INT.vhd" \
	"$DOT_PRODUCT_GENERIC_ROOT/INT_TCU/Multiplier_INT.vhd" \
	"$DOT_PRODUCT_GENERIC_ROOT/INT_TCU/DPU_TOP_INT.vhd" \
	"$DOT_PRODUCT_GENERIC_ROOT/INT_TCU/TC_INT_top.vhd" \
	"# TB - Top-level" \
	"$DOT_PRODUCT_GENERIC_ROOT/INT_TCU/TC_INT_TB.vhd" \
]

foreach src $dot_product_files_vhdls {
	if [expr {[string first # $src] eq 0}] {puts $src} else {
		#exec >@stdout 2>@stderr
		vcom -64 -2008 -work work $src
	}
}

vsim -64 -voptargs=+acc work.TC_core_TB
#vsim -voptargs=+acc work.tb_top_level
#do TB_wave_internal_golden.do
#run 200 ns
