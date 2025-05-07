LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity register_file is
    port(
        Reset : in std_logic;
        Clock : in std_logic;
        register_select : in std_logic_vector(4 downto 0);
        Rin : in std_logic;
        Rout : in std_logic;
        BAOut : in std_logic;
        cpu_bus : inout std_logic_vector(31 downto 0) := (others => 'Z')
    );
end register_file;

architecture rtl of register_file is
    type register_array is array (31 downto 0) of std_logic_vector(31 downto 0);
    signal register_Q : register_array;
begin    
    Rin_process : process(Clock, Reset, register_select, Rin, Rout, BAout)
        variable i : integer := 0;
    begin
        if (Reset = '1') then
            register_Q <= (others => (others => '0'));
        elsif rising_edge(Clock) then
            if (Rin = '1') then
                register_Q(to_integer(unsigned(register_select))) <= cpu_bus;
            end if;
        end if;
    end process Rin_process;

    Rout_process : process(Rout, Clock, register_select, BAOut, register_Q)
    begin
        if (Rout = '1') then
            cpu_bus <= register_Q(to_integer(unsigned(register_select)));
        elsif (BAOut = '1') then
            if (register_select = "00000") then
                cpu_bus <= (others => '0');
            else
                cpu_bus <= register_Q(to_integer(unsigned(register_select)));
            end if;
        else
            cpu_bus <= (others => 'Z');
        end if;
    end process Rout_process;
end rtl;