LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL;

entity control_signals_logic is
  port(
    opcode : in std_logic_vector(4 downto 0);
    t0 : in std_logic;
    t1 : in std_logic;
    t2 : in std_logic;
    t3 : in std_logic;
    t4 : in std_logic;
    t5 : in std_logic;
    t6 : in std_logic;
    t7 : in std_logic;
    neq0      : in   std_logic;
    con       : in   std_logic;
    irin      : out std_logic;
    c1out     : out std_logic;
    c2out     : out std_logic;
    gra       : out std_logic;
    grb       : out std_logic;
    grc       : out std_logic;
    main      : out std_logic;
    mdbus     : out std_logic;
    mdrd      : out std_logic;
    mdout     : out std_logic;
    pcin      : out std_logic;
    pcout     : out std_logic;
    ain       : out std_logic;
    cin       : out std_logic;
    cout      : out std_logic;
    add_op    : out std_logic;
    sub_op    : out std_logic;
    neg_op    : out std_logic;
    and_op    : out std_logic;
    or_op     : out std_logic;
    not_op    : out std_logic;
    shr_op    : out std_logic;
    shra_op   : out std_logic;
    shl_op    : out std_logic;
    shc_op    : out std_logic;
    ceqb_op   : out std_logic;
    incr4_op  : out std_logic;
    baout     : out std_logic;
    rin       : out std_logic;
    rout      : out std_logic;
    end_sig : out std_logic;
    stop_sig : out std_logic;
    read_control : out std_logic; -- to sequencer
    write_control : out std_logic; -- to sequencer
    wait_sig : out std_logic;
    goto6 : out std_logic;
    conin     : out std_logic;
    ld_shift      : out std_logic;
    decr      : out std_logic
    );
end control_signals_logic;

architecture rtl of control_signals_logic is
    COMPONENT opcode_decoder
	PORT(
        opcode : in std_logic_vector(4 downto 0);
        nop_instr : out std_logic;
        ld_instr : out std_logic;
        ldr_instr : out std_logic;
        st_instr : out std_logic;
        str_instr : out std_logic;
        la_instr : out std_logic;
        lar_instr : out std_logic;
        br_instr : out std_logic;
        brl_instr : out std_logic;
        add_instr : out std_logic;
        addi_instr : out std_logic;
        sub_instr : out std_logic;
        neg_instr : out std_logic;
        and_instr : out std_logic;
        andi_instr : out std_logic;
        or_instr : out std_logic;
        ori_instr : out std_logic;
        not_instr : out std_logic;
        shr_instr : out std_logic;
        shra_instr : out std_logic;
        shl_instr : out std_logic;
        shc_instr : out std_logic;
        stop_instr : out std_logic
	);
    END COMPONENT;
    signal nop_instr : std_logic;
    signal ld_instr : std_logic;
    signal ldr_instr : std_logic;
    signal st_instr : std_logic;
    signal str_instr : std_logic;
    signal la_instr : std_logic;
    signal lar_instr : std_logic;
    signal br_instr : std_logic;
    signal brl_instr : std_logic;
    signal add_instr : std_logic;
    signal addi_instr : std_logic;
    signal sub_instr : std_logic;
    signal neg_instr : std_logic;
    signal and_instr : std_logic;
    signal andi_instr : std_logic;
    signal or_instr : std_logic;
    signal ori_instr : std_logic;
    signal not_instr : std_logic;
    signal shr_instr : std_logic;
    signal shra_instr : std_logic;
    signal shl_instr : std_logic;
    signal shc_instr : std_logic;
    signal stop_instr : std_logic;

    constant delay : time := 5 ns;

begin
    b2v_opcode_decoder : opcode_decoder
    port map(
        opcode => opcode,
        nop_instr => nop_instr,
        ld_instr => ld_instr,
        ldr_instr => ldr_instr,
        st_instr => st_instr,
        str_instr => str_instr,
        la_instr => la_instr,
        lar_instr => lar_instr,
        br_instr => br_instr,
        brl_instr => brl_instr,
        add_instr => add_instr,
        addi_instr => addi_instr,
        sub_instr => sub_instr,
        neg_instr => neg_instr,
        and_instr => and_instr,
        andi_instr => andi_instr,
        or_instr => or_instr,
        ori_instr => ori_instr,
        not_instr => not_instr,
        shr_instr => shr_instr,
        shra_instr => shra_instr,
        shl_instr => shl_instr,
        shc_instr => shc_instr,
        stop_instr => stop_instr
    );

    read_control  <= (t1) or (t6 and (ld_instr or ldr_instr)) after delay;
    write_control <= (t7 and (st_instr or str_instr)) after delay;
    wait_sig      <= (t1) or (t6 and (ld_instr or ldr_instr)) or (t7 and (st_instr or str_instr)) after delay;
    pcout         <= (t0) or (t3 and (ldr_instr or str_instr or lar_instr or brl_instr)) after delay;
    pcin          <= (t1) or (t4 and br_instr and con) or (t5 and brl_instr and con) after delay;
    main          <= (t0) or (t5 and (ld_instr or ldr_instr or st_instr or str_instr)) after delay;
    mdbus         <= (t6 and (st_instr or str_instr)) after delay;
    mdrd          <= (t1) or (t6 and (ld_instr or ldr_instr)) after delay;
    mdout         <= (t2) or (t7 and (ld_instr or ldr_instr)) after delay;
    irin          <= (t2) after delay;
    rin           <= (t3 and brl_instr) or (t5 and (la_instr or lar_instr or add_instr or addi_instr or sub_instr or neg_instr or and_instr or andi_instr or or_instr or ori_instr or not_instr)) or (t7 and (ld_instr or ldr_instr or shr_instr or shra_instr or shl_instr or shc_instr)) after delay;
    rout          <= (t6 and (st_instr or str_instr)) or (t3 and br_instr) or (t4 and con and br_instr) or (t4 and brl_instr) or (t5 and con and brl_instr) or (t3 and (add_instr or addi_instr or sub_instr or neg_instr or not_instr or and_instr or andi_instr or or_instr or ori_instr)) or (t4 and (add_instr or sub_instr or neg_instr or not_instr or and_instr or or_instr)) or (t4 and neq0 and (shr_instr or shra_instr or shl_instr or shc_instr)) or (t5 and (shr_instr or shra_instr or shl_instr or shc_instr)) after delay;
    baout         <= (t3 and (ld_instr or st_instr or la_instr)) after delay;
    gra           <= (t3 and brl_instr) or (t5 and (la_instr or lar_instr or add_instr or addi_instr or sub_instr or neg_instr or and_instr or andi_instr or or_instr or ori_instr or not_instr)) or (t6 and (st_instr or str_instr)) or (t7 and (ld_instr or ldr_instr or st_instr or str_instr or shr_instr or shra_instr or shl_instr or shc_instr)) after delay;
    grb           <= (t3 and (ld_instr or st_instr or la_instr or add_instr or addi_instr or sub_instr or and_instr or andi_instr or or_instr or ori_instr)) or (t4 and br_instr) or (t5 and (brl_instr or shr_instr or shra_instr or shl_instr or shc_instr)) after delay;
    grc           <= (t3 and br_instr) or (t4 and brl_instr) or (t4 and (add_instr or sub_instr or neg_instr or not_instr or and_instr or or_instr)) or (t4 and neq0 and (shr_instr or shra_instr or shl_instr or shc_instr)) after delay;
    c1out         <= (t3 and (shr_instr or shra_instr or shl_instr or shc_instr)) or (t4 and (ldr_instr or str_instr or lar_instr)) after delay;
    c2out         <= (t4 and (ld_instr or st_instr or la_instr or addi_instr or andi_instr or ori_instr)) after delay;
    cin           <= (t0) or (t4 and (ld_instr or ldr_instr or st_instr or str_instr or la_instr or lar_instr or add_instr or addi_instr or sub_instr or neg_instr or and_instr or andi_instr or or_instr or ori_instr or not_instr)) or (t5 and (shr_instr or shra_instr or shl_instr or shc_instr)) or (t6 and not neq0 and (shr_instr or shra_instr or shl_instr or shc_instr)) after delay;
    cout          <= t1 or (t5 and (ld_instr or ldr_instr or st_instr or str_instr or la_instr or lar_instr)) or (t5 and (add_instr or addi_instr or sub_instr or neg_instr or not_instr or and_instr or andi_instr or or_instr or ori_instr)) or (t6 and not(neq0) and (shr_instr or shra_instr or shl_instr or shc_instr)) or (t7 and (shr_instr or shra_instr or shl_instr or shc_instr)) after delay;
    ain           <= (t3 and (ld_instr or ldr_instr or st_instr or str_instr or la_instr or lar_instr or add_instr or addi_instr or sub_instr or and_instr or andi_instr or or_instr or ori_instr)) after delay;
    conin         <= (t3 and br_instr) or (t4 and brl_instr) after delay;
    ld_shift      <= (t3 and shr_instr) or (t4 and shr_instr and Neq0) or (t3 and shra_instr) or (t4 and shra_instr and Neq0) or (t3 and shl_instr) or (t4 and shl_instr and Neq0) or (t3 and shc_instr) or (t4 and shc_instr and Neq0) after delay;
    ceqb_op       <= (t5 and (shr_instr or shra_instr or shl_instr or shc_instr)) after delay;
    decr          <= (not Neq0) and ((t6 and shr_instr) or (t6 and shra_instr) or (t6 and shl_instr) or (t6 and shc_instr)) after delay;
    goto6         <= (not Neq0) and ((t6 and shr_instr) or (t6 and shra_instr) or (t6 and shl_instr) or (t6 and shc_instr)) after delay;
    end_sig       <= (t3 and nop_instr) or (t4 and br_instr) or (t5 and (la_instr or lar_instr or brl_instr or add_instr or addi_instr or sub_instr or neg_instr or and_instr or andi_instr or or_instr or ori_instr or not_instr)) or (t7 and (ld_instr or ldr_instr or st_instr or str_instr or shr_instr or shra_instr or shl_instr or shc_instr)) after delay;
    stop_sig      <= (t3 and stop_instr) after delay;

    incr4_op      <= (t0) after delay;
    add_op        <= (t4 and (ld_instr or ldr_instr or st_instr or str_instr or la_instr or lar_instr or add_instr or addi_instr)) after delay;
    sub_op        <= (t4 and sub_instr) after delay;
    neg_op        <= (t4 and neg_instr) after delay;
    and_op        <= (t4 and (and_instr or andi_instr)) after delay;
    or_op         <= (t4 and (or_instr or ori_instr)) after delay;
    not_op        <= (t4 and not_instr) after delay;
    shr_op        <= (t6 and shr_instr) after delay;
    shra_op       <= (t6 and shra_instr) after delay;
    shl_op        <= (t6 and shl_instr) after delay;
    shc_op        <= (t6 and shc_instr) after delay;
end rtl;