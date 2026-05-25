#!/usr/bin/tclsh
set GPGPU_GENERIC_ROOT "../../../.."

# from python launcher required.
#set path_rtl_design $::env(PATH_RTL_DESIGN)
#set path_rtl_tb $::env(PATH_RTL_TB)
#set top_module $::env(TOP_MODULE_RTL)
#set tech_lib $::env(PATH_TECH_LIB)
#set vcd_file_name $::env(PATH_NEW_VCD_FILE_NAME)


quit -sim

exec vlib work
#exec vmap gpgpu work

set cores_vhdls [list \
	"# reference components" \
	"../../FP/DPU_arch1/def_package.vhd" \
	"# Top-level, reference components" \
	"../../FP/DPU_arch1/right_shifter.vhd" \
	"../../FP/DPU_arch1/fp_leading_zeros_and_shift.vhd" \
	"../../FP/DPU_arch1/prueba.vhd" \
	"../../FP/DPU_arch1/suma_resta.vhd" \
	"../../FP/DPU_arch1/multiplier_FP.vhd" \
	"../../FP/DPU_arch1/dot_unit_core.vhd" \
	"../../FP/DPU_arch1/FP_tensor_core_4x4x4.vhd" \
	"TC_tb.vhd"
]


# the same unit used by nick to collect the patterns
# vlog 	 ../../../../../../syn_libraries/15nm/verilog/NanGate_15nm_OCL_functional.v
# vlog     ../../../cores/GL/Flo-posit/DPU/DPU_unit_15_polito_cadence.v


foreach src $cores_vhdls {
	if [expr {[string first # $src] eq 0}] {puts $src} else {
		#exec >@stdout 2>@stderr
		vcom -64 -2008 -work work $src
	#	vcom +cover=cbesxf -coveropt 1 -64 -2008 -work work $src
	}
}


vsim -64 -voptargs=+acc work.TC_core_TB
#vsim -64 -voptargs=+acc work.Posit32_add_GL_TB
#vsim -voptargs=+acc work.Posit32_add_TB

#toggle add sim:/tb_top_level/uGPGPU/uStreamingMultiProcessor/temp_vector_register_re(0)(0)(0)(0)

# In debuging mode, it must be activated...
# ********************************************************************

# vcd add -file branch_waves.vcd -internal -ports -r tb_top_level/uGPGPU/uStreamingMultiProcessor/uPipelineexecute/uBranchExecuteUnit/*
# vcd add -file posit32_add_GL.vcd -ports -r Posit32_add_GL_TB/DUT0/*





vcd add -file FP_TC.vcd -ports TC_core_TB/TCU0/*






# ********************************************************************

#vcd 
#vcd add -file branch_trace.vcd -internal -ports -r tb_top_level/uGPGPU/uStreamingMultiProcessor/uPipelineexecute/*

#vcd file 
#vcd add tb_top_level/uGPGPU/uStreamingMultiProcessor/uPipelineDecode/* 


#force -freeze tb_top_level/uGPGPU/uStreamingMultiProcessor/uPipelineExecute/uSpecialFunctionUnitProcessor/gSpecialFunctionUnit(0)/uSpecialFunctionUnit/s_in_sign 0

# do wave_custom_JDGB.do
#do wave_custom_JDGB_fault_list.do
# do wave.do

#do wave_comparison.do
run -all

#run 10000ns  # limit of simulation

#coverage report -verbose -all -file coverage_rep.tg -instance sim:tb_top_level/uGPGPU/uStreamingMultiProcessor/uPipelineExecute/*
# coverage save coverage_report.ucdb
# toggle report -file generated_toogle_report.txt -all

#vcd flush XXX_decode.vcd

# quit
