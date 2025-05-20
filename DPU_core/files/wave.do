onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Inputs
add wave -noupdate /dot_unit_core_tb/c_X0_s
add wave -noupdate /dot_unit_core_tb/b_X3_s
add wave -noupdate /dot_unit_core_tb/b_X2_s
add wave -noupdate /dot_unit_core_tb/b_X1_s
add wave -noupdate /dot_unit_core_tb/b_X0_s
add wave -noupdate /dot_unit_core_tb/a_X3_s
add wave -noupdate /dot_unit_core_tb/a_X2_s
add wave -noupdate /dot_unit_core_tb/a_X1_s
add wave -noupdate /dot_unit_core_tb/a_X0_s
add wave -noupdate -divider outputs
add wave -noupdate /dot_unit_core_tb/w_XX3_s
add wave -noupdate /dot_unit_core_tb/underflow_s
add wave -noupdate /dot_unit_core_tb/overflow_s
add wave -noupdate -divider {Internal units}
add wave -noupdate -divider FMUL0
add wave -noupdate /dot_unit_core_tb/DUT0/FMUL0/salida
add wave -noupdate -divider FMUL1
add wave -noupdate /dot_unit_core_tb/DUT0/FMUL1/salida
add wave -noupdate -divider FMUL2
add wave -noupdate /dot_unit_core_tb/DUT0/FMUL2/salida
add wave -noupdate -divider FMUL3
add wave -noupdate /dot_unit_core_tb/DUT0/FMUL3/salida
add wave -noupdate -divider ADDER0
add wave -noupdate /dot_unit_core_tb/DUT0/ADDER0/resultado
add wave -noupdate -divider ADDER1
add wave -noupdate /dot_unit_core_tb/DUT0/ADDER1/resultado
add wave -noupdate -divider ADDER2
add wave -noupdate /dot_unit_core_tb/DUT0/ADDER2/resultado
add wave -noupdate -divider ADDER3
add wave -noupdate /dot_unit_core_tb/DUT0/ADDER3/resultado
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {67 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {256 ns}
