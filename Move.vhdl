library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity Move is
    port(QA, QB, Clk25, Reset: in std_logic;
        Rot_Left, Rot_Right: out std_logic);
end entity;

architecture comport of Move is
    type state is (E0, E1);
    signal Ep, Ef: state;
    begin
    process(Clk25, Reset)                   -- MàJ de l'état.
        begin
        if (Reset = '0') then
            Ep <= E0;
        elsif (rising_edge(Clk25)) then
            Ep <= Ef;
        end if;
    end process;
    process(Ep, QA)                             -- Contrôle de la MÀÉ.
        begin
        Rot_Left <= '0';
        Rot_Right <= '0';
        case Ep is
            when E0 => if (QA'event) then Ef <= E1; else Ef <= E0; end if;
            when E1 => if (QB = QA) then Rot_Right <= '1'; elsif (QB = not(QA)) then Rot_Left <= '1'; end if; Ef <= E0;
            when others => null;
        end case;
    end process;
end architecture;
