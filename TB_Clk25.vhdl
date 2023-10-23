library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity TB_Clk25 is
end entity;

architecture bench of TB_Clk25 is
    signal H: std_logic;
    signal R, Clk: std_logic := '0';
    begin
    R <= '1' after 25 ns;
    Clk <= not(Clk) after 10 ns;
    Clock: entity work.Clk25(comport)
        port map(Clk, R, H);
end architecture;
