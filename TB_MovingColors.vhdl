library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity TB_MovingColors is
end entity;

architecture bench of TB_MovingColors is
    signal Reset: std_logic;
    signal Clk: std_logic := '0';
    signal r, g, b: std_logic_vector(3 downto 0);
    begin
    MovCol: entity work.Moving_Colors(comport)
        port map(Clk, Reset, r, g, b);
    Clk <= not(Clk) after 10 us;
    Reset <= '0', '1' after 100 us;
end architecture;
