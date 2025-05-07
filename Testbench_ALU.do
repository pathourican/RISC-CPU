vcom -93 -work work {C:\Users\phour\OneDrive\Desktop\ECE4435\LearningActivities\LearningActivity5\src_brc\BasicRISCCPUTestbench.vhd}
vcom -93 -work work {C:\Users\phour\OneDrive\Desktop\ECE4435\LearningActivities\LearningActivity5\src_brc/clock_reset_start.vhd}
vcom -93 -work work {C:\Users\phour\OneDrive\Desktop\ECE4435\LearningActivities\LearningActivity5\src_brc/memory_bus_controller.vhd}
vcom -93 -work work {C:\Users\phour\OneDrive\Desktop\ECE4435\LearningActivities\LearningActivity5\src_brc/ram_6116.vhd}
vcom -93 -work work {C:\Users\phour\OneDrive\Desktop\ECE4435\LearningActivities\LearningActivity5\src_brc/rom_27c64.vhd}

vsim work.BasicRISCCPUTestbench

add wave -position insertpoint  \
add wave -position insertpoint  \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/cpu_bus \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/c3_2_downto_0 \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_datapath/b2v_IR/register_Q \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_datapath/b2v_PC/register_Q \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_datapath/b2v_RegisterFile/register_Q \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_control_unit/b2v_ControlSignalsLogic/
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_control_unit/b2v_CONLogic/

run 400000 ns

