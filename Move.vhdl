library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Move is 
port(QA,QB,reset,clk25: in std_logic;
     Rot_Left,Rot_Right: out std_logic);
end entity;

architecture comport of Move is
type etat is (EtatAtt_0,EtatAtt_1,G0,G1,D1,D0);
signal EP,EF: etat ;
begin 
    process(clk25,reset) 
    begin
    if reset= '0' then EP<=EtatAtt_0;
    elsif rising_edge(clk25) then EP<=EF;
    end if;
    end process;
    
    process(EP,QA,QB)
    begin
    case (EP) is 
    when EtatAtt_0 => EF<=EtatAtt_0;
        if (QA = '1' and QB='0') then EF<=G0;
        elsif (QA='1' and QB='1') then EF<= D0;
        end if;
    when G0 => EF<=EtatAtt_1;
    when D0 => EF<= EtatAtt_1;
    when EtatAtt_1 => EF<= EtatAtt_1;
        if (QA = '0' and QB='0') then EF<=D1;
        elsif (QA = '0' and QB='1') then EF<=G1;
        end if;
    when G1 => EF<=EtatAtt_0;
    when D1 => EF<= EtatAtt_0;
    end case;
    end process;
    
    process(EP)
    begin 
    case (EP) is
    when EtatAtt_0 => Rot_Left <= '0' ; Rot_Right <='0';
    when G0 => Rot_Left <= '1' ; Rot_Right<='0';
    when D0 => Rot_Left <= '0' ; Rot_Right<='1';
    when EtatAtt_1 => Rot_Left <= '0' ; Rot_Right <='0';
    when G1 => Rot_Left <= '1' ; Rot_Right<='0';
    when D1 => Rot_Left <= '0' ; Rot_Right<='1';
    end case;
    end process;
end architecture;
