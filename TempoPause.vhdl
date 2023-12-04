library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity TempoPause is
    port(Reset, Clk25: in std_logic;
        RAZ_Tempo_Pause, Update_Tempo_Pause: in std_logic;
        Fin_Tempo_Pause: out std_logic);
end entity;

architecture comport of TempoPause is
    signal incr: std_logic_vector(9 downto 0);
    begin
    process(Reset, Clk25)
        begin
        if (Reset = '0') then
            incr <= (others => '0');
        else
            if (rising_edge(Clk25)) then
                if (RAZ_Tempo_Pause = '1') then
                    incr <= (others => '0');
                elsif (RAZ_Tempo_Pause = '1') then
                    incr <= (others => '0');
                elsif (Update_Tempo_Pause = '1') then
                    incr <= incr+1;
                end if;
            end if;
        end if;
    end process;
    Fin_Tempo_Pause <= incr(0) and incr(1) and incr(2) and incr(3) and incr(4) and incr(5) and incr(6) and incr(7) and incr(8) and incr(9);
end architecture;
