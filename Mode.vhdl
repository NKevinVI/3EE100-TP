library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity Mode is
    port(Clk25: in std_logic;
        Lost: in std_logic;
        No_Brick: in std_logic;
        Reset: in std_logic;
        Endframe: in std_logic;
        Pause_Rqt: in std_logic;
        Game_Lost: out std_logic;
        Brick_Win: out std_logic;
        Pause: out std_logic);
end entity;

architecture comport of Mode is
    type state is (E0, E1);
    signal Ep, Ef: state;
    signal RAZ_Tempo_Pause, Update_Tempo_Pause, Fin_Tempo_Pause: std_logic;
    signal Load_Timer_Lost, Update_Timer_Lost, Timer_Lost: std_logic;
    begin

    Tempo: entity work.TempoPause(comport)
        port map(Reset, Clk25, RAZ_Tempo_Pause, Update_Tempo_Pause, Fin_Tempo_Pause);

    Timer: entity work.TimerLost(comport)
        port map(Load_Timer_Lost, Update_Timer_Lost, Reset, Clk25, Game_Lost, Timer_Lost);

    MAE: process()
    end process;
end architecture;
