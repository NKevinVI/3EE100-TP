library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity TB_Clk20 is

end entity;

architecture bench of TB_Clk20 is
    signal clock,reset: std_logic :='0';
    signal clkint:std_logic;


begin
    MC: entity work.clk20
    port map(clock,reset,clkint);
    clock<=not clock after 10 ns;
    reset<='1' after 3 ns;


end architecture;
