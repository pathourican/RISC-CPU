-- Copyright (C) 2021  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.


LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY control_unit IS 
	PORT
	(
		reset :  IN  STD_LOGIC;
		clock :  IN  STD_LOGIC;
		start :  IN  STD_LOGIC;
		done :  IN  STD_LOGIC;
		c3_2_downto_0 :  IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		opcode :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		cpu_bus :  INOUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r_memory :  OUT  STD_LOGIC;
		w_memory :  OUT  STD_LOGIC;
		main :  OUT  STD_LOGIC;
		mdwr :  OUT  STD_LOGIC;
		mdbus :  OUT  STD_LOGIC;
		mdrd :  OUT  STD_LOGIC;
		mdout :  OUT  STD_LOGIC;
		pcin :  OUT  STD_LOGIC;
		pcout :  OUT  STD_LOGIC;
		ain :  OUT  STD_LOGIC;
		cin :  OUT  STD_LOGIC;
		cout :  OUT  STD_LOGIC;
		Irin :  OUT  STD_LOGIC;
		c1out :  OUT  STD_LOGIC;
		c2out :  OUT  STD_LOGIC;
		baout :  OUT  STD_LOGIC;
		rin :  OUT  STD_LOGIC;
		rout :  OUT  STD_LOGIC;
		gra :  OUT  STD_LOGIC;
		grb :  OUT  STD_LOGIC;
		grc :  OUT  STD_LOGIC;
		add_op :  OUT  STD_LOGIC;
		sub_op :  OUT  STD_LOGIC;
		neg_op :  OUT  STD_LOGIC;
		and_op :  OUT  STD_LOGIC;
		or_op :  OUT  STD_LOGIC;
		not_op :  OUT  STD_LOGIC;
		shr_op :  OUT  STD_LOGIC;
		shra_op :  OUT  STD_LOGIC;
		shl_op :  OUT  STD_LOGIC;
		shc_op :  OUT  STD_LOGIC;
		ceqb_op :  OUT  STD_LOGIC;
		incr4_op :  OUT  STD_LOGIC
	);
END control_unit;

ARCHITECTURE bdf_type OF control_unit IS 

COMPONENT con_logic
	PORT(Reset : IN STD_LOGIC;
		 Clock : IN STD_LOGIC;
		 CONin : IN STD_LOGIC;
		 c3_2_downto_0 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 cpu_bus : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 CON : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT control_signals_logic
	PORT(t0 : IN STD_LOGIC;
		 t1 : IN STD_LOGIC;
		 t2 : IN STD_LOGIC;
		 t3 : IN STD_LOGIC;
		 t4 : IN STD_LOGIC;
		 t5 : IN STD_LOGIC;
		 t6 : IN STD_LOGIC;
		 t7 : IN STD_LOGIC;
		 neq0 : IN STD_LOGIC;
		 con : IN STD_LOGIC;
		 opcode : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 irin : OUT STD_LOGIC;
		 c1out : OUT STD_LOGIC;
		 c2out : OUT STD_LOGIC;
		 gra : OUT STD_LOGIC;
		 grb : OUT STD_LOGIC;
		 grc : OUT STD_LOGIC;
		 main : OUT STD_LOGIC;
		 mdbus : OUT STD_LOGIC;
		 mdrd : OUT STD_LOGIC;
		 mdout : OUT STD_LOGIC;
		 pcin : OUT STD_LOGIC;
		 pcout : OUT STD_LOGIC;
		 ain : OUT STD_LOGIC;
		 cin : OUT STD_LOGIC;
		 cout : OUT STD_LOGIC;
		 add_op : OUT STD_LOGIC;
		 sub_op : OUT STD_LOGIC;
		 neg_op : OUT STD_LOGIC;
		 and_op : OUT STD_LOGIC;
		 or_op : OUT STD_LOGIC;
		 not_op : OUT STD_LOGIC;
		 shr_op : OUT STD_LOGIC;
		 shra_op : OUT STD_LOGIC;
		 shl_op : OUT STD_LOGIC;
		 shc_op : OUT STD_LOGIC;
		 ceqb_op : OUT STD_LOGIC;
		 incr4_op : OUT STD_LOGIC;
		 baout : OUT STD_LOGIC;
		 rin : OUT STD_LOGIC;
		 rout : OUT STD_LOGIC;
		 end_sig : OUT STD_LOGIC;
		 stop_sig : OUT STD_LOGIC;
		 read_control : OUT STD_LOGIC;
		 write_control : OUT STD_LOGIC;
		 wait_sig : OUT STD_LOGIC;
		 goto6 : OUT STD_LOGIC;
		 conin : OUT STD_LOGIC;
		 ld_shift : OUT STD_LOGIC;
		 decr : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT sequencer
	PORT(Reset : IN STD_LOGIC;
		 Clock : IN STD_LOGIC;
		 Start : IN STD_LOGIC;
		 Done : IN STD_LOGIC;
		 End_sig : IN STD_LOGIC;
		 Goto6 : IN STD_LOGIC;
		 Read_control : IN STD_LOGIC;
		 Write_control : IN STD_LOGIC;
		 Wait_sig : IN STD_LOGIC;
		 Stop_sig : IN STD_LOGIC;
		 t0 : OUT STD_LOGIC;
		 t1 : OUT STD_LOGIC;
		 t2 : OUT STD_LOGIC;
		 t3 : OUT STD_LOGIC;
		 t4 : OUT STD_LOGIC;
		 t5 : OUT STD_LOGIC;
		 t6 : OUT STD_LOGIC;
		 t7 : OUT STD_LOGIC;
		 r_sequencer : OUT STD_LOGIC;
		 w_sequencer : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT shift_control
	PORT(Reset : IN STD_LOGIC;
		 Clock : IN STD_LOGIC;
		 ld_shift : IN STD_LOGIC;
		 Decr : IN STD_LOGIC;
		 cpu_bus : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 Neq0 : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	con :  STD_LOGIC;
SIGNAL	conin :  STD_LOGIC;
SIGNAL	decr :  STD_LOGIC;
SIGNAL	end_sig :  STD_LOGIC;
SIGNAL	goto6 :  STD_LOGIC;
SIGNAL	ld_shift :  STD_LOGIC;
SIGNAL	neq0 :  STD_LOGIC;
SIGNAL	read_control :  STD_LOGIC;
SIGNAL	stop_sig :  STD_LOGIC;
SIGNAL	t0 :  STD_LOGIC;
SIGNAL	t1 :  STD_LOGIC;
SIGNAL	t2 :  STD_LOGIC;
SIGNAL	t3 :  STD_LOGIC;
SIGNAL	t4 :  STD_LOGIC;
SIGNAL	t5 :  STD_LOGIC;
SIGNAL	t6 :  STD_LOGIC;
SIGNAL	t7 :  STD_LOGIC;
SIGNAL	w_memory_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	wait_sig :  STD_LOGIC;
SIGNAL	write_control :  STD_LOGIC;


BEGIN 



b2v_CONLogic : con_logic
PORT MAP(Reset => reset,
		 Clock => clock,
		 CONin => conin,
		 c3_2_downto_0 => c3_2_downto_0,
		 cpu_bus => cpu_bus,
		 CON => con);


b2v_ControlSignalsLogic : control_signals_logic
PORT MAP(t0 => t0,
		 t1 => t1,
		 t2 => t2,
		 t3 => t3,
		 t4 => t4,
		 t5 => t5,
		 t6 => t6,
		 t7 => t7,
		 neq0 => neq0,
		 con => con,
		 opcode => opcode,
		 irin => Irin,
		 c1out => c1out,
		 c2out => c2out,
		 gra => gra,
		 grb => grb,
		 grc => grc,
		 main => main,
		 mdbus => mdbus,
		 mdrd => mdrd,
		 mdout => mdout,
		 pcin => pcin,
		 pcout => pcout,
		 ain => ain,
		 cin => cin,
		 cout => cout,
		 add_op => add_op,
		 sub_op => sub_op,
		 neg_op => neg_op,
		 and_op => and_op,
		 or_op => or_op,
		 not_op => not_op,
		 shr_op => shr_op,
		 shra_op => shra_op,
		 shl_op => shl_op,
		 shc_op => shc_op,
		 ceqb_op => ceqb_op,
		 incr4_op => incr4_op,
		 baout => baout,
		 rin => rin,
		 rout => rout,
		 end_sig => end_sig,
		 stop_sig => stop_sig,
		 read_control => read_control,
		 write_control => write_control,
		 wait_sig => wait_sig,
		 goto6 => goto6,
		 conin => conin,
		 ld_shift => ld_shift,
		 decr => decr);


b2v_Sequencer : sequencer
PORT MAP(Reset => reset,
		 Clock => clock,
		 Start => start,
		 Done => done,
		 End_sig => end_sig,
		 Goto6 => goto6,
		 Read_control => read_control,
		 Write_control => write_control,
		 Wait_sig => wait_sig,
		 Stop_sig => stop_sig,
		 t0 => t0,
		 t1 => t1,
		 t2 => t2,
		 t3 => t3,
		 t4 => t4,
		 t5 => t5,
		 t6 => t6,
		 t7 => t7,
		 r_sequencer => r_memory,
		 w_sequencer => w_memory_ALTERA_SYNTHESIZED);


b2v_ShiftControl : shift_control
PORT MAP(Reset => reset,
		 Clock => clock,
		 ld_shift => ld_shift,
		 Decr => decr,
		 cpu_bus => cpu_bus,
		 Neq0 => neq0);

w_memory <= w_memory_ALTERA_SYNTHESIZED;
mdwr <= w_memory_ALTERA_SYNTHESIZED;

END bdf_type;