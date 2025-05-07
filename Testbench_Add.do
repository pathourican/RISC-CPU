vcom -93 -work work {C:\Users\phour\OneDrive\Desktop\ECE4435\LearningActivities\LearningActivity5\src_brc\BasicRISCCPUTestbench.vhd}
vcom -93 -work work {C:\Users\phour\OneDrive\Desktop\ECE4435\LearningActivities\LearningActivity5\src_brc/clock_reset_start.vhd}
vcom -93 -work work {C:\Users\phour\OneDrive\Desktop\ECE4435\LearningActivities\LearningActivity5\src_brc/memory_bus_controller.vhd}
vcom -93 -work work {C:\Users\phour\OneDrive\Desktop\ECE4435\LearningActivities\LearningActivity5\src_brc/ram_6116.vhd}
vcom -93 -work work {C:\Users\phour\OneDrive\Desktop\ECE4435\LearningActivities\LearningActivity5\src_brc/rom_27c64.vhd}

vsim work.BasicRISCCPUTestbench

add wave -position insertpoint  \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/clock \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_datapath/b2v_PC/register_Q \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_datapath/b2v_IR/register_Q \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_datapath/b2v_RegisterFile/register_Q(4) \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_datapath/b2v_RegisterFile/register_Q(3) \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_datapath/b2v_RegisterFile/register_Q(2) \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_datapath/b2v_RegisterFile/register_Q(1) \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/r \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/w \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_memory_interface/memstrobe \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_memory_interface/ma_contents \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_memory_interface/Addr_Bus \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_memory_interface/Data_Bus \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_memory_interface/md_contents \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_memory_interface/cpu_bus \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_control_unit/wait_sig \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/done \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_control_unit/t0 \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_control_unit/t1 \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_control_unit/t2 \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_control_unit/t3 \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_control_unit/t4 \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_control_unit/t5 \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_control_unit/t6 \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_control_unit/t7 \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_control_unit/b2v_Sequencer/t_counter \
sim:/basicrisccputestbench/b2v_BasicRISCCPU/b2v_control_unit/b2v_Sequencer/current_state \
sim:/basicrisccputestbench/b2v_ram3/ram_contents(1) \
sim:/basicrisccputestbench/b2v_ram2/ram_contents(1) \
sim:/basicrisccputestbench/b2v_ram1/ram_contents(1) \
sim:/basicrisccputestbench/b2v_ram0/ram_contents(1)

run 25000 ns