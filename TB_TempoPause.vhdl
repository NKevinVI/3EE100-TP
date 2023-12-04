library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity TB_TempoPause is
end entity;

architecture bench of TB_TempoPause is
    signal reset, raz, update, fin: std_logic;
    signal clk25: std_logic := '0';
    begin
    func: entity work.TempoPause(comport)
        port map(
            reset,
            clk25,
            raz,
            update,
            fin
        );
    clk25 <= not(clk25) after 40 ns;
    reset <= '0', '1' after 3 ms;
    raz <= '1', '0' after 3.1 ms;
    update <= '0', '1' after 4 ms;
end architecture;
