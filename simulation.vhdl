----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2023 09:15:00
-- Design Name: 
-- Module Name: simulation - Behavioral
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity simulation is

end simulation;

architecture Behavioral of simulation is
    signal clock,reset: std_logic :='0';
    signal clkint:std_logic;


begin
    MC: entity work.clk20
    port map(clock,reset,clkint);
    clock<=not clock after 10 ns;
    reset<='1' after 3 ns;


end Behavioral;
