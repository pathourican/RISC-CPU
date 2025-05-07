LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity opcode_decoder is
port(
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
    een_instr : out std_logic;
    edi_instr : out std_logic;
    add_instr : out std_logic;
    addi_instr : out std_logic;
    sub_instr : out std_logic;
    neg_instr : out std_logic;
    svi_instr : out std_logic;
    ri_instr : out std_logic;
    and_instr : out std_logic;
    andi_instr : out std_logic;
    or_instr : out std_logic;
    ori_instr : out std_logic;
    not_instr : out std_logic;
    shr_instr : out std_logic;
    shra_instr : out std_logic;
    shl_instr : out std_logic;
    shc_instr : out std_logic;
    rfi_instr : out std_logic;
    stop_instr : out std_logic
);

    end opcode_decoder;

architecture rtl of opcode_decoder is
begin
    decode : process(opcode)
    begin
        nop_instr  <= not opcode(4) and not opcode(3) and not opcode(2) and not opcode(1) and not opcode(0); -- 0  - 00000
        ld_instr   <= not opcode(4) and not opcode(3) and not opcode(2) and not opcode(1) and     opcode(0); -- 1  - 00001
        ldr_instr  <= not opcode(4) and not opcode(3) and not opcode(2) and     opcode(1) and not opcode(0); -- 2  - 00010
        st_instr   <= not opcode(4) and not opcode(3) and not opcode(2) and     opcode(1) and     opcode(0); -- 3  - 00011
        str_instr  <= not opcode(4) and not opcode(3) and     opcode(2) and not opcode(1) and not opcode(0); -- 4  - 00100
        la_instr   <= not opcode(4) and not opcode(3) and     opcode(2) and not opcode(1) and     opcode(0); -- 5  - 00101
        lar_instr  <= not opcode(4) and not opcode(3) and     opcode(2) and     opcode(1) and not opcode(0); -- 6  - 00110
        br_instr   <= not opcode(4) and     opcode(3) and not opcode(2) and not opcode(1) and not opcode(0); -- 8  - 01000
        brl_instr  <= not opcode(4) and     opcode(3) and not opcode(2) and not opcode(1) and     opcode(0); -- 9  - 01001
        een_instr  <= not opcode(4) and     opcode(3) and not opcode(2) and     opcode(1) and not opcode(0); -- 10 - 01010
        edi_instr  <= not opcode(4) and     opcode(3) and not opcode(2) and     opcode(1) and     opcode(0); -- 11 - 01011
        add_instr  <= not opcode(4) and     opcode(3) and     opcode(2) and not opcode(1) and not opcode(0); -- 12 - 01100
        addi_instr <= not opcode(4) and     opcode(3) and     opcode(2) and not opcode(1) and     opcode(0); -- 13 - 01101
        sub_instr  <= not opcode(4) and     opcode(3) and     opcode(2) and     opcode(1) and not opcode(0); -- 14 - 01110
        neg_instr  <= not opcode(4) and     opcode(3) and     opcode(2) and     opcode(1) and     opcode(0); -- 15 - 01111
        svi_instr  <=     opcode(4) and not opcode(3) and not opcode(2) and not opcode(1) and not opcode(0); -- 16 - 10000
        ri_instr   <=     opcode(4) and not opcode(3) and not opcode(2) and not opcode(1) and     opcode(0); -- 17 - 10001
        and_instr  <=     opcode(4) and not opcode(3) and     opcode(2) and not opcode(1) and not opcode(0); -- 20 - 10100
        andi_instr <=     opcode(4) and not opcode(3) and     opcode(2) and not opcode(1) and     opcode(0); -- 21 - 10101
        or_instr   <=     opcode(4) and not opcode(3) and     opcode(2) and     opcode(1) and not opcode(0); -- 22 - 10110
        ori_instr  <=     opcode(4) and not opcode(3) and     opcode(2) and     opcode(1) and     opcode(0); -- 23 - 10111
        not_instr  <=     opcode(4) and     opcode(3) and not opcode(2) and not opcode(1) and not opcode(0); -- 24 - 11000
        shr_instr  <=     opcode(4) and     opcode(3) and not opcode(2) and     opcode(1) and not opcode(0); -- 26 - 11010
        shra_instr <=     opcode(4) and     opcode(3) and not opcode(2) and     opcode(1) and     opcode(0); -- 27 - 11011
        shl_instr  <=     opcode(4) and     opcode(3) and     opcode(2) and not opcode(1) and not opcode(0); -- 28 - 11100
        shc_instr  <=     opcode(4) and     opcode(3) and     opcode(2) and not opcode(1) and     opcode(0); -- 29 - 11101
        rfi_instr  <=     opcode(4) and     opcode(3) and     opcode(2) and     opcode(1) and not opcode(0); -- 30 - 11110
		stop_instr <=     opcode(4) and     opcode(3) and     opcode(2) and     opcode(1) and     opcode(0); -- 31 - 11111
        
    end process decode;

end rtl;
