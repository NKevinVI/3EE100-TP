library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity TB_Move is
end entity;

architecture bench of TB_Move is
    signal a, b: std_logic := '0';
    signal left, right: std_logic;
    signal Clk100: std_logic := '0';
    signal res: std_logic := '0';
    signal clk: std_logic;
    begin
    inst: entity work.Move(comport)
        port map(a, b, clk, res, left, right);
    Clock: entity work.Clk25(comport)
        port map(Clk100, res, clk);
    res <= '1' after 30 ns;
    Clk100 <= not(Clk100) after 5 ns;
    a <= '1' after 80 ns, '0' after 280 ns, '1' after 481 ns, '0' after 584 ns;
    b <= '1' after 160 ns, '0' after 320 ns, '1' after 441 ns, '0' after 524 ns;
end architecture;
