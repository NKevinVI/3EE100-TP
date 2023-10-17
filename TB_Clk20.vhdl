library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity TB_Clk20 is
end entity;

architecture bench of TB_Clk20 is
    signal Clk100: std_logic := '0';
    signal Reset: std_logic;
    signal Clk_int: std_logic;
    begin
    Clock: entity work.Clk20(comport)
        port map(Clk100, Reset, Clk_int);
    Clk100 <= not(Clk100) after 0.5 ns;
    Reset <= '0', '1' after 500 us;
end architecture;
