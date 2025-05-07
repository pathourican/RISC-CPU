LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use ieee.std_logic_misc.all;

entity con_logic is
    port(
        Reset : in std_logic;
        Clock : in std_logic;
        CONin : in std_logic;
        CON : out std_logic;
        c3_2_downto_0 : in std_logic_vector(2 downto 0);
        cpu_bus : inout std_logic_vector(31 downto 0) := (others => 'Z')
    );
end con_logic;

architecture rtl of con_logic is
    signal con_reg : std_logic;
    signal d : std_logic;
    signal one : std_logic;
    signal two : std_logic;
    signal three : std_logic;
    signal four : std_logic;
    signal five : std_logic;
    signal cpu_nor : std_logic;
begin
    decode : process(c3_2_downto_0)
    begin
        one <= '0';
        two <= '0';
        three <= '0';
        four <= '0';
        five <= '0';
        if (c3_2_downto_0 = "001") then
            one <= '1';
        elsif (c3_2_downto_0 = "010") then
            two <= '1';
        elsif (c3_2_downto_0 = "011") then
            three <= '1';
        elsif (c3_2_downto_0 = "100") then
            four <= '1';
        elsif (c3_2_downto_0 = "101") then
            five <= '1';
        end if;
    end process decode;

    reg: process(Clock, Reset, c3_2_downto_0)
    begin
        if (Reset = '1') then
            con_reg <= '0';
        elsif (rising_edge(Clock)) then
            if (CONin = '1') then
                con_reg <= d;
            end if;
        end if;
    end process reg;
    
    CON <= con_reg;
    d <= (one) or (two and nor_reduce(cpu_bus)) or (three and not nor_reduce(cpu_bus)) or (four and not cpu_bus(31)) or (five and cpu_bus(31));
end rtl;