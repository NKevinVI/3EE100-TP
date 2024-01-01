library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mode is
    Port ( Pause_Rqt : in STD_LOGIC;
           Endframe : in STD_LOGIC;     -- Entr¨¦es
           Lost : in STD_LOGIC;
           No_Brick : in STD_LOGIC;
           
           Clock : in STD_LOGIC;        -- Synchro
           Reset : in STD_LOGIC;
           
           Game_Lost : out STD_LOGIC;   -- Sorties
           Brick_Win : out STD_LOGIC;
           Pause : out STD_LOGIC);
end Mode;

architecture Behavioral of Mode is

type etat is (Pa, Pa_Actif, Actif_Pa, Actif, Perdu, Gagne);
signal EP, EF: etat;

signal Fin_Tempo_Pause: std_logic;
signal RAZ_Tempo_Pause, Update_Tempo_Pause :std_logic;
signal Load_Timer_Lost, Update_Timer_Lost,Lost_Game: std_logic;

begin
    Tempo_Pause : entity work.TempoPause 
    port map(Reset,clock,RAZ_Tempo_Pause, Update_Tempo_Pause,Fin_Tempo_Pause);
    
    Timer_Lost: entity work.TimerLost
    port map(Load_Timer_Lost, Update_Timer_Lost, Reset, Clock,EndFrame,Lost_Game);

    process(Clock, Reset)   -- Gestion Changement d'¨¦tat
    begin
        if Reset = '0' then EP <= Pa;
        elsif rising_edge(Clock) then EP <= EF;
        end if;
    end process;
    
    process(EP, Pause_Rqt, EndFrame, Lost, No_Brick, Fin_Tempo_Pause, Lost_Game) -- Gestion ¨¦tat futur
    begin
        case(EP) is
            when Pa => EF <= Pa; if Pause_Rqt = '1' then EF <= Pa_Actif; end if;
            when Pa_Actif => EF <= Pa_Actif; if Fin_Tempo_Pause = '1' and Pause_Rqt = '0' then EF <= Actif; end if;
            when Actif_Pa => EF <= Actif_Pa; if Fin_Tempo_Pause = '1' and Pause_Rqt = '0' then EF <= Pa; end if;
            when Actif => EF <= Actif;
                if Pause_Rqt = '1' then EF <= Actif_Pa;
                elsif Lost = '1' then EF <= Perdu;
                elsif No_Brick = '1' then EF <= Gagne;
                end if;
            when Perdu =>
                if Lost_Game = '1' then EF <= Actif; 
                else  EF <= Perdu; 
                end if;
            when Gagne => EF <= Gagne;
        end case;
    end process;
    
    process(EP) -- Gestion des sorties
    begin
        case(EP) is
            when Pa =>          Game_Lost <= '0'; Brick_win <= '0'; Pause <= '1';RAZ_Tempo_Pause<='1';Update_Tempo_Pause<='0';Load_Timer_Lost<='1'; Update_Timer_Lost<='0';
            when Pa_Actif =>    Game_Lost <= '0'; Brick_win <= '0'; Pause <= '0';RAZ_Tempo_Pause<='0';Update_Tempo_Pause<='1';Load_Timer_Lost<='0'; Update_Timer_Lost<='0';
            when Actif_Pa =>    Game_Lost <= '0'; Brick_win <= '0'; Pause <= '1';RAZ_Tempo_Pause<='0';Update_Tempo_Pause<='1';Load_Timer_Lost<='0'; Update_Timer_Lost<='0';
            when Actif =>       Game_Lost <= '0'; Brick_win <= '0'; Pause <= '0';RAZ_Tempo_Pause<='1';Update_Tempo_Pause<='0';Load_Timer_Lost<='1'; Update_Timer_Lost<='0';
            when Perdu =>       Game_Lost <= '1'; Brick_win <= '0'; Pause <= '0';RAZ_Tempo_Pause<='0';Update_Tempo_Pause<='0';Load_Timer_Lost<='0'; Update_Timer_Lost<='1';
            when Gagne =>       Game_Lost <= '0'; Brick_win <= '1'; Pause <= '0';RAZ_Tempo_Pause<='0';Update_Tempo_Pause<='0';Load_Timer_Lost<='0'; Update_Timer_Lost<='0';
        end case;
    end process;
    

    


end Behavioral;
