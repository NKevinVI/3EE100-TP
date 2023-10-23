----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/10/18 22:21:57
-- Design Name: 
-- Module Name: CompteurR - Behavioral
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity CompteurR is
   Port (ClK,reset: in std_logic;
         com: in std_logic_vector (1 downto 0);
           sortie: out std_logic_vector(4 downto 0));
end CompteurR;

architecture comport of CompteurR is
    signal reg: std_logic_vector(4 downto 0);
begin
    sortie<= reg;
    process(CLk, Reset)
        begin
        if (Reset = '0') then
            reg <= (others => '1');
       elsif rising_edge(CLK) then 
           case(com) is 
           
           when "01" => reg <= reg - 1;
           when "10" => reg <= reg + 1;
           when others => NULL;
           end case;
        end if;
    end process;
end architecture;