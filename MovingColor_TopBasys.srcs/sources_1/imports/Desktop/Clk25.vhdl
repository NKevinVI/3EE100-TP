library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CLKdiv is
port(CLK100,reset:in std_logic;
     CLK25:out std_logic);
end entity;

architecture comport of CLKdiv is
    signal div: std_logic_vector(3 downto 0);
begin
    process(CLK100,reset)
    begin
        if reset='0' then
            div<=(others => '0');
            ClK25<='0';
        elsif rising_edge(CLK100) then
            if div="01" then
                CLK25<='1';
                div<=div+1;
            elsif div ="11" then
                CLK25<='0';
                div<=(others => '0');
            else
                div<=div+1;
            end if;
        end if;
    end process;
end comport;