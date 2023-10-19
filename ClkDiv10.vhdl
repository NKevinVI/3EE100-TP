library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_arith.all;


entity ClkDiv10 is
    port(Clk100: in std_logic;
        Reset: in std_logic;
        Clk10: out std_logic);
end entity;

architecture comport of ClkDiv10 is
    signal cpt: std_logic_vector(3 downto 0) := "0000";
    signal clk: std_logic := '0';
    begin
    Clk10 <= clk;
    process(Clk100, Reset)
        begin
        if (Clk100'event and Clk100 = '1') then
            if (cpt = "1010") then
                cpt <= (others => '0');
                clk <= not(clk);
            else
                cpt <= cpt+1;
            end if;
        end if;
    end process;
end architecture;
