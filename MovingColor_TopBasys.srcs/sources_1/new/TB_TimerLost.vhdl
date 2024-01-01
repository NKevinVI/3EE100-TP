library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity TB_TimerLost is
end entity;

architecture bench of TB_TimerLost is
    signal Load_Timer_Lost, Update_Timer_Lost, Reset, game_lost: std_logic;
    signal endframe, clk25: std_logic := '0';
    begin
    do_it: entity work.TimerLost(comport)
        port map(Load_Timer_Lost, Update_Timer_Lost, Reset, clk25, endframe, game_lost);
    clk25 <= not(clk25) after 5 ns;         -- Valeur prise au hasard (non représentative de la réalité).
    Reset <= '0', '1' after 15 ns;
    Endframe <= not(endframe) after 100 ns;
    Load_Timer_Lost <= '1', '0' after 50 ns;
    Update_Timer_Lost <= '0', '1' after 55 ns;
end architecture;
