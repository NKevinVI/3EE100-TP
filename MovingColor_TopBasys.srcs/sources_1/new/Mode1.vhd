library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Mode is 
    port (Pause_Rqt,EndFrame,Lost,No_Brick,Clk25,Reset: in std_logic;
        Brick_Win, Pause,Game_lost: out std_logic);
end entity;

architecture arch of Mode is 
type etat is (Init,inter_1,Actif,inter_2,arret,Gagne,Perdu,inter_3,inter_4);
signal EP,EF: etat ;
signal RAZ_Tempo_Pause,Update_Tempo_Pause,Load_Timer_Lost,Update_Timer_Lost,Fin_Tempo_Pause: std_logic;
signal GL : std_logic;
begin

    process(clk25,reset)
    begin
    if reset='0' then EP<=Init;
        elsif rising_edge(clk25) then EP<=EF;
    end if;
    end process;
    
    process(EP,Pause_Rqt,EndFrame,Lost,No_Brick,Fin_Tempo_Pause)
    begin
    case(EP) is 
    when Init => EF<= Init;
        if(Pause_Rqt='1') then EF <= inter_1;
        end if;
    when inter_1 => EF <= inter_1;
        if(Pause_rqt='0' and Fin_tempo_Pause='1') then EF<=Actif;
        end if;
    when Actif => EF<=Actif;
        if Pause_rqt='1' then EF<=inter_2;
        elsif No_Brick='1' then EF<=Gagne;
        elsif (No_Brick='0' and Lost='1') then EF<=Perdu;
        end if;
    when inter_2 => EF <= inter_2;
        if (Pause_Rqt='0' and Fin_Tempo_Pause='1') then EF<=arret;
        end if;
    when arret => EF <= arret;
        if Pause_Rqt='1' then EF <= inter_1;
        end if;
    when Perdu => EF<= inter_3;
    when inter_3 => EF<= inter_3;
        if GL='0' then EF<=Init;
        elsif endframe = '1' then EF <= inter_4;
        end if;
    end case;
    end process;
    
    Tempopause : entity work.TempoPause 
    port map(Reset, Clk25,RAZ_Tempo_Pause, Update_Tempo_Pause,Fin_Tempo_Pause);
    TimerLost : entity work.TimerLost
    port map(Load_Timer_Lost,Update_Timer_Lost, Reset, Clk25,GL);
    
    
    
    
--    process(EP)
--    begin 
--    case(EP) is 
    
--    when Init => RAZ_Tempo_Pause<='1';Update_Tempo_Pause<='0';Load_Timer_Lost<='0';Update_Timer_Lost<='0';Fin_Tempo_Pause<='0';Timer_Lost<='0';
--    when inter_1=> Update_Tempo_Pause<='1'; RAZ_Tempo_Pause<='0';Load_Timer_Lost<='0';Update_Timer_Lost<='0';Fin_Tempo_Pause<='0';Timer_Lost<='0';
--    when Actif => RAZ_Tempo_Pause<='1'; Update_Tempo_Pause<='0';Load_Timer_Lost<='0';Update_Timer_Lost<='0';Fin_Tempo_Pause<='0';Timer_Lost<='0';
--    when inter_2=> Update_Tempo_Pause<='1'; RAZ_Tempo_Pause<='0';Load_Timer_Lost<='0';Update_Timer_Lost<='0';Fin_Tempo_Pause<='0';Timer_Lost<='0';
--    when arret => RAZ_Tempo_Pause<='1'; Update_Tempo_Pause<='0';Load_Timer_Lost<='0';Update_Timer_Lost<='0';Fin_Tempo_Pause<='0';Timer_Lost<='0';Pause<='1';
--    when Perdu => Load_Timer_Lost<='1'; RAZ_Tempo_Pause<='0';Update_Tempo_Pause<='0';Update_Timer_Lost<='0';Fin_Tempo_Pause<='0';Timer_Lost<='0';
--    when inter_3 =>Game_lost<='1'; RAZ_Tempo_Pause<='0';Update_Tempo_Pause<='0';Load_Timer_Lost<='0';Update_Timer_Lost<='0';Fin_Tempo_Pause<='0';Timer_Lost<='0';
--    when inter_4 => Update_Timer_Lost<='1'; RAZ_Tempo_Pause<='0';Update_Tempo_Pause<='0';Load_Timer_Lost<='0';Fin_Tempo_Pause<='0';Timer_Lost<='0';
--    when Gagne => Brick_Win<='1'; RAZ_Tempo_Pause<='0';Update_Tempo_Pause<='0';Load_Timer_Lost<='0';Update_Timer_Lost<='0';Fin_Tempo_Pause<='0';Timer_Lost<='0';
--    end case;
--    end process;
   
    RAZ_Tempo_Pause<= '1' when (EP=Init or EP=Actif or EP=arret) else '0';
    Update_Tempo_Pause<='1' when (EP=inter_1 or EP=inter_2) else '0';
    Load_Timer_Lost<='1' when EP=Perdu else '0';
    Game_lost<='1' when (EP=inter_3 and GL ='1') or EP =inter_4 else '0';
    Update_Timer_Lost<='1' when EP = inter_4 else '0';
    Brick_Win<='1' when EP = Gagne else '0';
    Pause<='1' when (EP=arret or EP = inter_3 or EP=inter_4 or EP=Perdu) else '0';

    
end arch;
    
