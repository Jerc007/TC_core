onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sub_tensor_core_tb/W_0X3_golden_s
add wave -noupdate /sub_tensor_core_tb/W_1X3_golden_s
add wave -noupdate /sub_tensor_core_tb/W_2X3_golden_s
add wave -noupdate /sub_tensor_core_tb/W_3X3_golden_s
add wave -noupdate /sub_tensor_core_tb/underflow_s
add wave -noupdate /sub_tensor_core_tb/overflow_s
add wave -noupdate /sub_tensor_core_tb/clk_s
add wave -noupdate /sub_tensor_core_tb/rst_s
add wave -noupdate /sub_tensor_core_tb/W_0X3_s
add wave -noupdate /sub_tensor_core_tb/W_1X3_s
add wave -noupdate /sub_tensor_core_tb/W_2X3_s
add wave -noupdate /sub_tensor_core_tb/W_3X3_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {99 ns} 0}
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
WaveRestoreZoom {0 ns} {1 us}
