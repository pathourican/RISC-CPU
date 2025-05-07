LIBRARY ieee;
USE ieee.std_logic_1164.all; 

entity program_counter is
    port(
        Reset   : in std_logic;
        Clock   : in std_logic;
        PCin    : in std_logic;
        PCout   : in std_logic;
        cpu_bus : inout std_logic_vector(31 downto 0) := (others => 'Z')
    );
end program_counter;

architecture rtl of program_counter is
    signal register_Q : std_logic_vector(31 downto 0);
    
begin
    
    reg: process (Clock, Reset, PCout, register_Q) 
    begin
        if(Reset = '1') then
            register_Q <=  (others => '0');
        elsif rising_edge(Clock) then
            if(PCin = '1') then 
                register_Q <= cpu_bus;
            end if;
        end if;
    end process reg;

    tristate: process (Clock, PCout, register_Q)
    begin
        if (PCout = '1') then
            cpu_bus <= register_Q;
        else 
            cpu_bus <= (others => 'Z');
        end if;
    end process tristate;
end rtl;
  
