library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity TimerLost is
    port(Load_Timer_Lost, Update_Timer_Lost, Reset, Clk25: in std_logic;
        Game_Lost: out std_logic;
        Timer_Lost: out std_logic_vector(5 downto 0));
end entity;

architecture comport of TimerLost is
    signal timer: std_logic_vector(5 downto 0);
    begin
    Timer_Lost <= timer;
    process(Reset, Clk25)
        begin
        if (Reset = '0') then
            timer <= (others => '1');
        else
            if (Load_Timer_Lost = '1') then
                timer <= "111111";
            elsif (Update_Timer_Lost = '1') then
                timer <= timer-1;
            end if;
        end if;
    end process;
    Game_Lost <= not(timer(0)) and not(timer(1)) and not(timer(2)) and not(timer(3)) and not(timer(4)) and not(timer(5));
end architecture;
