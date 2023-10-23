library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity TB_Top is

end entity;

architecture bench of TB_Top is
signal Clock, Reset: std_logic:='0';
signal R, G, B: std_logic_vector(3 downto 0);
signal  H :  STD_LOGIC;
 signal V :  STD_LOGIC;
begin
    MC: entity work.top
    port map(Clock, Reset,r,g,b,H,v);
    
    clock <= not clock after 10 ns;
    reset <= '1' after 3 ns;

end architecture;
