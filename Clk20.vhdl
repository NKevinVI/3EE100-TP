library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity CLK20 is
port(CLK100,reset:in std_logic;
     CLock_int:out std_logic);
end entity;

architecture comport of CLK20 is
    signal div: std_logic_vector(22 downto 0);
begin
    process(Clk100, Reset)   -- diviseur 20Hz
    begin
        if Reset = '0' then div <= "00000000000000000000000"; clock_int <= '0';
        elsif rising_edge(clk100) then 
            if div = "00100110001001011001111" then clock_int <= '1'; div <= div + '1';
            elsif div = "01001100010010110011111" then clock_int <= '0'; div <= "00000000000000000000000";
            else div <= div + '1';
            end if;
        end if;
    end process;
end comport;
