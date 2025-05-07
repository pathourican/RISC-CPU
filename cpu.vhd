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

ENTITY cpu IS 
	PORT
	(
		reset :  IN  STD_LOGIC;
		clock :  IN  STD_LOGIC;
		start :  IN  STD_LOGIC;
		done :  IN  STD_LOGIC;
		memstrobe :  IN  STD_LOGIC;
		data_bus :  INOUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		r :  OUT  STD_LOGIC;
		w :  OUT  STD_LOGIC;
		addr_bus :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END cpu;

ARCHITECTURE bdf_type OF cpu IS 

COMPONENT control_unit
	PORT(reset : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 start : IN STD_LOGIC;
		 done : IN STD_LOGIC;
		 c3_2_downto_0 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 cpu_bus : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 opcode : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 r_memory : OUT STD_LOGIC;
		 w_memory : OUT STD_LOGIC;
		 main : OUT STD_LOGIC;
		 mdwr : OUT STD_LOGIC;
		 mdbus : OUT STD_LOGIC;
		 mdrd : OUT STD_LOGIC;
		 mdout : OUT STD_LOGIC;
		 pcin : OUT STD_LOGIC;
		 pcout : OUT STD_LOGIC;
		 ain : OUT STD_LOGIC;
		 cin : OUT STD_LOGIC;
		 cout : OUT STD_LOGIC;
		 Irin : OUT STD_LOGIC;
		 c1out : OUT STD_LOGIC;
		 c2out : OUT STD_LOGIC;
		 baout : OUT STD_LOGIC;
		 rin : OUT STD_LOGIC;
		 rout : OUT STD_LOGIC;
		 gra : OUT STD_LOGIC;
		 grb : OUT STD_LOGIC;
		 grc : OUT STD_LOGIC;
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
		 incr4_op : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT datapath
	PORT(reset : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 pcin : IN STD_LOGIC;
		 pcout : IN STD_LOGIC;
		 ain : IN STD_LOGIC;
		 cin : IN STD_LOGIC;
		 cout : IN STD_LOGIC;
		 irin : IN STD_LOGIC;
		 c1out : IN STD_LOGIC;
		 c2out : IN STD_LOGIC;
		 baout : IN STD_LOGIC;
		 rin : IN STD_LOGIC;
		 rout : IN STD_LOGIC;
		 gra : IN STD_LOGIC;
		 grb : IN STD_LOGIC;
		 grc : IN STD_LOGIC;
		 add_op : IN STD_LOGIC;
		 sub_op : IN STD_LOGIC;
		 neg_op : IN STD_LOGIC;
		 and_op : IN STD_LOGIC;
		 or_op : IN STD_LOGIC;
		 not_op : IN STD_LOGIC;
		 shr_op : IN STD_LOGIC;
		 shra_op : IN STD_LOGIC;
		 shl_op : IN STD_LOGIC;
		 shc_op : IN STD_LOGIC;
		 ceqb_op : IN STD_LOGIC;
		 incr4_op : IN STD_LOGIC;
		 cpu_bus : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 c3_2_downto_0 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 opcode : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

COMPONENT memory_interface
	PORT(Reset : IN STD_LOGIC;
		 Clock : IN STD_LOGIC;
		 memstrobe : IN STD_LOGIC;
		 MAin : IN STD_LOGIC;
		 MDwr : IN STD_LOGIC;
		 MDbus : IN STD_LOGIC;
		 MDrd : IN STD_LOGIC;
		 MDout : IN STD_LOGIC;
		 cpu_bus : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 Data_Bus : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 Addr_Bus : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	add_op :  STD_LOGIC;
SIGNAL	ain :  STD_LOGIC;
SIGNAL	and_op :  STD_LOGIC;
SIGNAL	baout :  STD_LOGIC;
SIGNAL	c1out :  STD_LOGIC;
SIGNAL	c2out :  STD_LOGIC;
SIGNAL	c3_2_downto_0 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	ceqb_op :  STD_LOGIC;
SIGNAL	cin :  STD_LOGIC;
SIGNAL	cout :  STD_LOGIC;
SIGNAL	cpu_bus :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	gra :  STD_LOGIC;
SIGNAL	grb :  STD_LOGIC;
SIGNAL	grc :  STD_LOGIC;
SIGNAL	incr4_op :  STD_LOGIC;
SIGNAL	irin :  STD_LOGIC;
SIGNAL	main :  STD_LOGIC;
SIGNAL	mdbus :  STD_LOGIC;
SIGNAL	mdout :  STD_LOGIC;
SIGNAL	mdrd :  STD_LOGIC;
SIGNAL	mdwr :  STD_LOGIC;
SIGNAL	neg_op :  STD_LOGIC;
SIGNAL	not_op :  STD_LOGIC;
SIGNAL	opcode :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	or_op :  STD_LOGIC;
SIGNAL	pcin :  STD_LOGIC;
SIGNAL	pcout :  STD_LOGIC;
SIGNAL	rin :  STD_LOGIC;
SIGNAL	rout :  STD_LOGIC;
SIGNAL	shc_op :  STD_LOGIC;
SIGNAL	shl_op :  STD_LOGIC;
SIGNAL	shr_op :  STD_LOGIC;
SIGNAL	shra_op :  STD_LOGIC;
SIGNAL	sub_op :  STD_LOGIC;


BEGIN 



b2v_control_unit : control_unit
PORT MAP(reset => reset,
		 clock => clock,
		 start => start,
		 done => done,
		 c3_2_downto_0 => c3_2_downto_0,
		 cpu_bus => cpu_bus,
		 opcode => opcode,
		 r_memory => r,
		 w_memory => w,
		 main => main,
		 mdwr => mdwr,
		 mdbus => mdbus,
		 mdrd => mdrd,
		 mdout => mdout,
		 pcin => pcin,
		 pcout => pcout,
		 ain => ain,
		 cin => cin,
		 cout => cout,
		 Irin => irin,
		 c1out => c1out,
		 c2out => c2out,
		 baout => baout,
		 rin => rin,
		 rout => rout,
		 gra => gra,
		 grb => grb,
		 grc => grc,
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
		 incr4_op => incr4_op);


b2v_datapath : datapath
PORT MAP(reset => reset,
		 clock => clock,
		 pcin => pcin,
		 pcout => pcout,
		 ain => ain,
		 cin => cin,
		 cout => cout,
		 irin => irin,
		 c1out => c1out,
		 c2out => c2out,
		 baout => baout,
		 rin => rin,
		 rout => rout,
		 gra => gra,
		 grb => grb,
		 grc => grc,
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
		 cpu_bus => cpu_bus,
		 c3_2_downto_0 => c3_2_downto_0,
		 opcode => opcode);


b2v_memory_interface : memory_interface
PORT MAP(Reset => reset,
		 Clock => clock,
		 memstrobe => memstrobe,
		 MAin => main,
		 MDwr => mdwr,
		 MDbus => mdbus,
		 MDrd => mdrd,
		 MDout => mdout,
		 cpu_bus => cpu_bus,
		 Data_Bus => data_bus,
		 Addr_Bus => addr_bus);


END bdf_type;