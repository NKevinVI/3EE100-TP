library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_ClkDiv10 is
end entity;

architecture bench of TB_ClkDiv10 is

signal H_100, RAZ: std_logic:='0';
signal H_10: std_logic;

begin

-- Instanciation Diviseur d'horloge
l0: entity work.ClkDiv10
	port map(
		clk100	=> H_100,
		reset	=> RAZ,
		clk10	=> H_10);

-- G�n�ration des Signaux d'Entr�e
H_100<=not H_100 after 5 ns;
RAZ <='1' after 3 ns;

end architecture;
