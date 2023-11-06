library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pong_pack.ALL;



entity SIMU_ip_rotary is
end SIMU_ip_rotary;

architecture Behavioral of SIMU_ip_rotary is
signal reset,rot_a,rot_b,rot_left,rot_right : std_logic;
signal clk25 : std_logic :='0';

begin
ip_rotary : entity work.ip_rotary
            port map(clk25,reset,rot_a,rot_b,rot_left,rot_right);

clk25 <= not clk25 after 10 ns ;
reset <= '1', '0' after 25 ns;
rot_a <= '0', '1' after 55 ns, '0' after 95 ns, '1' after 135 ns, '0' after 175 ns;
rot_b <= '0', '1' after 65 ns, '0' after 105 ns, '1' after 125 ns, '0' after 165 ns;
end Behavioral;
