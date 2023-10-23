----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/10/18 22:21:57
-- Design Name: 
-- Module Name: CompteurV - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_arith.all;


entity CompteurG is
    port (Clk, reset: in std_logic;
        Com: in std_logic_vector(1 downto 0);
        Sortie: out std_logic_vector(4 downto 0));
end entity;

architecture comport of CompteurG is
    signal reg: std_logic_vector(4 downto 0);
    begin
    sortie <= reg;
    process(Clk, reset)
    begin
    if (reset = '0') then
        reg <= (others => '0');
    elsif (Clk'event and Clk = '1') then
        case (Com) is
            when "10" => reg <= reg+1;
            when "01" => reg <= reg-1;
            when others => null;
        end case;
    end if;
    end process;
end architecture;
