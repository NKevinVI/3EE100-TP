library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;


entity TB_Mode is
end entity;

architecture bench of TB_Mode is
    signal Lost, No_Brick, Reset, Pause_Rqt, Game_Lost, Brick_Win, Pause: std_logic;
    signal Clk25, Endframe: std_logic := '0';
    begin
    test: entity work.Mode(comport)
        port map(Clk25, Lost, No_Brick, Reset, Endframe, Pause_Rqt, Game_Lost, Brick_Win, Pause);
    Clk25 <= not(Clk25) after 400 ns;
    Reset <= '0', '1' after 2 us;
    Endframe <= not(Endframe) after 3 us;
    Pause_Rqt <= '0', '1' after 2 ms, '0' after 2.1 ms, '1' after 4 ms, '0' after 4.1 ms, '1' after 5 ms, '0' after 5.1 ms;
    No_Brick <= '0', '1' after 6 ms;
    Lost <= '0', '1' after 5.01 ms;
end architecture;
