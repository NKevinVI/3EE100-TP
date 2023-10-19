library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_arith.all;


entity Clk25 is
    port(Clk100: in std_logic;
        Reset: in std_logic;
        Clk_25: out std_logic);
end entity;

architecture comport of Clk25 is
    signal reg: std_logic_vector(1 downto 0);
    begin
    Clk_25 <= not(reg(1));
    process(CLk100, Reset)
        begin
        if (Reset = '0') then
            reg <= (others => '0');
        elsif (Clk100'event and Clk100 = '1') then
            reg <= reg+1;
        end if;
    end process;
end architecture;
