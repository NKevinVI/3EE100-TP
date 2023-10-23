----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/10/18 23:26:01
-- Design Name: 
-- Module Name: simu - Behavioral
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


entity SimuMC is

end SimuMC;

architecture Behavioral of SimuMC is
signal Clock, Reset: std_logic:='0';
signal R, G, B: std_logic_vector(3 downto 0);
signal  H :  STD_LOGIC;
 signal V :  STD_LOGIC;
begin
    MC: entity work.top
    port map(Clock, Reset,r,g,b,H,v);
    
    clock <= not clock after 10ns;
    reset <= '1' after 3ns;

end Behavioral;
