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
    type state is (Init, P_int1, P_int2,  Actif, Perd, L);
    signal Ep, Ef: state;
    signal RAZ_Tempo_Pause, Update_Tempo_Pause, Fin_Tempo_Pause: std_logic;
    signal Load_Timer_Lost, Update_Timer_Lost: std_logic;
    signal Timer_Lost: std_logic_vector(5 downto 0);
    begin

    Tempo: entity work.TempoPause(comport)
        port map(Reset, Clk25, RAZ_Tempo_Pause, Update_Tempo_Pause, Fin_Tempo_Pause);

    Timer: entity work.TimerLost(comport)
        port map(Load_Timer_Lost, Update_Timer_Lost, Reset, Clk25, Game_Lost, Timer_Lost);

    MAE_Etat: process(Reset, Clk25)
        begin
        if (Reset = '0') then
            Ep <= Init;
        elsif (rising_edge(Clk25)) then
            Ep <= Ef;
        end if;
    end process;

    MAE_Turfu: process(Ep, Pause_rqt, Lost, No_Brick, Endframe)
        begin
        case Ep is
            when Init =>
                Brick_Win <= '0';
                Pause <= '1';
                RAZ_Tempo_Pause <= '1';
                Update_Tempo_Pause <= '0';
                Load_Timer_Lost <= '0';
                Update_Timer_Lost <= '0';
                if (Pause_Rqt = '1') then
                    Ef <= P_int2;
                else
                    Ef <= Init;
                end if;
            when Actif =>
                Brick_Win <= no_Brick;
                Pause <= '0';
                RAZ_Tempo_Pause <= '1';
                Update_Tempo_Pause <= '0';
                Load_Timer_Lost <= '0';
                Update_Timer_Lost <= '0';
                if (Pause_Rqt = '1') then
                    Ef <= P_int1;
                elsif (Lost = '1' and No_Brick = '0') then
                    Ef <= Perd;
                end if;
            when P_int1 =>
                Brick_Win <= No_Brick;
                Pause <= '0';
                RAZ_Tempo_Pause <= '0';
                Update_Tempo_Pause <= '1';
                Load_Timer_Lost <= '0';
                Update_Timer_Lost <= '0';
                if (Pause_Rqt = '0' and Fin_Tempo_Pause = '1') then
                    Ef <= Init;
                elsif (Lost = '1' and No_Brick = '0') then
                    Ef <= Perd;
                end if;
            when P_int2 =>
                Brick_Win <= '0';
                Pause <= '1';
                RAZ_Tempo_Pause <= '0';
                Update_Tempo_Pause <= '1';
                Load_Timer_Lost <= '0';
                Update_Timer_Lost <= '0';
                if (Pause_Rqt = '0' and Fin_Tempo_Pause = '1') then
                    Ef <= Actif;
                end if;
            when Perd =>
                Brick_Win <= '0';
                Pause <= '1';
                RAZ_Tempo_Pause <= '0';
                Update_Tempo_Pause <= '1';
                Load_Timer_Lost <= '1';
                Update_Timer_Lost <= '0';
                Ef <= L;
            when L =>
                Brick_Win <= '0';
                Pause <= '1';
                RAZ_Tempo_Pause <= '0';
                Update_Tempo_Pause <= '1';
                Load_Timer_Lost <= '0';
                if (Endframe = '1' and Timer_Lost > 0) then
                    Update_Timer_Lost <= '1';
                end if;
            when others => null;
        end case;
    end process;
end architecture;
