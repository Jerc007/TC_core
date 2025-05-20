#!/usr/bin/tclsh
set DOT_PRODUCT_GENERIC_ROOT "../"
quit -sim

exec vlib work

# exec vmap gpgpu work

set dot_product_files_vhdls [list \
	"## Package" \
	"$DOT_PRODUCT_GENERIC_ROOT/hw_sources/def_package.vhd" \
	"$DOT_PRODUCT_GENERIC_ROOT/hw_sources/FPAdd_3_pipe.vhd" \
	"$DOT_PRODUCT_GENERIC_ROOT/hw_sources/FPMult_3_pipe.vhd" \
	"$DOT_PRODUCT_GENERIC_ROOT/hw_sources/dot_unit_core.vhd" \
	"$DOT_PRODUCT_GENERIC_ROOT/hw_sources/sub_tensor_core.vhd" \
	"# TB - Top-level" \
	"$DOT_PRODUCT_GENERIC_ROOT/TB/sub_tensor_core_tb.vhd" \
]

foreach src $dot_product_files_vhdls {
	if [expr {[string first # $src] eq 0}] {puts $src} else {
		#exec >@stdout 2>@stderr
		vcom -64 -2008 -work work $src
	}
}

vsim -64 -voptargs=+acc work.sub_tensor_core_tb
#vsim -voptargs=+acc work.tb_top_level
do wave_sub_tensor.do
run 100 ns
