library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_arith.all;


entity ClkDiv10 is
    port(Clk100: in std_logic;
        Reset: in std_logic;
        Clk10: out std_logic);
end entity;

architecture comport of ClkDiv10 is
    signal reg: std_logic_vector(3 downto 0);
    begin
    
    process(CLk100, Reset)
        begin
        if (Reset = '0') then
            reg <= (others => '0');
        elsif (Clk100'event and Clk100 = '1') then
            reg <= reg+1;
        end if;
    end process;
    
    Clk10<=not((reg(3) and reg(1)));

end architecture;
