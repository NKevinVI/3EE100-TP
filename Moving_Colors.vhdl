library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Moving_Colors is
 Port (Clk100: in std_logic;
        reset: in std_logic ;
         Red_Out,Green_out,blue_out: out std_logic_vector(3 downto 0));
end entity;

architecture comport of Moving_Colors is
type etat is(E1, E2, E3);
signal Horloge: std_logic;
signal R,V,B: std_logic_vector(4 downto 0);
signal ComR, ComV, ComB, chg: std_logic_vector(1 downto 0);
signal EP, EF: etat;

begin 
    Horl20: entity work.CLK20(comport)
        port map (Clk100, reset,Horloge);

    compteurB : entity work.CompteurB(comport)
        port map(Horloge,reset,comB,B);
    compteurR : entity work.CompteurR(comport)
        port map(Horloge,reset,comR,R);
    compteurV : entity work.CompteurV(comport)
        port map(Horloge,reset,comV,V);

    Red_out<=r(4 downto 1);
    Green_out<=v(4 downto 1);
    Blue_out<=b(4 downto 1);

    process(CLK100, Reset)
    begin
        if Reset = '0' then EP <= E1;
        elsif rising_edge(CLK100) then EP <= EF;
        end if;
    end process;

    process(EP, R, V, B)
    begin
        case(EP) is
            when E1 => EF <= E1; if V = "11111" then EF <= E2; end if;
            when E2 => EF <= E2; if B = "11111" then EF <= E3; end if;
            when E3 => EF <= E3; if R = "11111" then EF <= E1; end if;
        end case;
    end process;
    
    process(EP)
    begin
        case(EP) is
            when E1 => comR <= "01"; comV <= "00"; comB <= "10";
            when E2 => comR <= "10"; comV <= "01"; comB <= "00";
            when E3 => comR <= "00"; comV <= "10"; comB <= "01";
        end case;
    end process;

end architecture;
