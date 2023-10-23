library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity CLKdiv is
port(CLK100,reset:in std_logic;
     CLK_int:out std_logic);
end entity;

architecture comport of CLKdiv is
    signal div: std_logic_vector(1 downto 0);
begin
    process(CLK100,reset)
    begin
        if reset='0' then
            div<=(others => '0');
            ClK_int<='0';
        elsif rising_edge(CLK100) then
            if div="01" then
                CLK_int<='1';
                div<=div+1;
            elsif div ="11" then
                CLK_int<='0';
                div<=(others => '0');
            else
                div<=div+1;
            end if;
        end if;
    end process;
end comport;
