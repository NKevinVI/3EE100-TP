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

type etat is (Pa, Pa_Actif, Actif_Pa, Actif, Perdu, Gagne, Timeout);
signal EP, EF: etat;

signal Fin_Tempo_Pause: std_logic;
signal Timer_Lost: std_logic_vector(5 downto 0);
signal Tempo_Pause: std_logic_vector(9 downto 0);
signal timer_game: std_logic_vector(7 downto 0);
signal clk1Hz: std_logic;
signal clk1Hz_count: std_logic_vector(23 downto 0);

begin
    process(Clock, Reset)   -- Gestion Changement d'¨¦tat
    begin
        if Reset = '0' then EP <= Pa;
        elsif rising_edge(Clock) then EP <= EF;
        end if;
    end process;
    
    process(EP, Pause_Rqt, EndFrame, Lost, No_Brick, Fin_Tempo_Pause, Timer_Lost) -- Gestion ¨¦tat futur
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
            when Perdu => EF <= Perdu; if Timer_Lost = "000000" then EF <= Actif; end if;
            when Gagne => EF <= Gagne;
            when Timeout => EF <= Timeout; 
        end case;
    end process;
    
    process(EP) -- Gestion des sorties
    begin
        case(EP) is
            when Pa =>          Game_Lost <= '0'; Brick_win <= '0'; Pause <= '1';
            when Pa_Actif =>    Game_Lost <= '0'; Brick_win <= '0'; Pause <= '0'; 
            when Actif_Pa =>    Game_Lost <= '0'; Brick_win <= '0'; Pause <= '1'; 
            when Actif =>       Game_Lost <= '0'; Brick_win <= '0'; Pause <= '0'; 
            when Perdu =>       Game_Lost <= '1'; Brick_win <= '0'; Pause <= '0'; 
            when Gagne =>       Game_Lost <= '0'; Brick_win <= '1'; Pause <= '0'; 
            
        end case;
    end process;

    process(Clock, Reset)
    begin
        if reset = '0' then Tempo_Pause <= "0000000000";
        
        elsif rising_edge(Clock) then
            if EP = Pa or EP = Actif then Tempo_Pause <= "0000000000";
            elsif (EP = Pa_Actif or Ep = Actif_Pa) and Tempo_Pause < "1111111111" then Tempo_Pause <= Tempo_Pause + '1';
            elsif Tempo_Pause = "1111111111" then Tempo_Pause <= Tempo_Pause;
            end if;
        end if;
    end process;
    Fin_Tempo_Pause <= Tempo_Pause(9) and Tempo_Pause(8) and Tempo_Pause(7) and Tempo_Pause(6) and Tempo_Pause(5) and Tempo_Pause(4) and Tempo_Pause(3) and Tempo_Pause(2) and Tempo_Pause(1) and Tempo_Pause(0);
    
    process(Clock, Reset)
    begin
        if reset = '0' then Timer_Lost <= "000000";
        
        elsif rising_edge(Clock) then
            if EP = Actif then Timer_Lost <= "111111";
            elsif EP = Perdu and Timer_Lost > "000000" and Endframe = '1' then Timer_Lost <= Timer_Lost - '1';
            else Timer_Lost <= Timer_Lost;
            end if;
        end if;
    end process;
    
    process(Clock, Reset)       -- diviseur 1Hz pour timer partie
    begin
        if Reset = '0' then Clk1Hz_count <= (others => '0'); Clk1Hz <= '0';
        elsif rising_edge(Clock) then 
            if Clk1Hz_count = "101111101011110000011111" then Clk1Hz <= not Clk1Hz; Clk1Hz_count <= (others => '0');
            else Clk1Hz_count <= Clk1Hz_count + '1';
            end if;
        end if;
    end process;
end Behavioral;
