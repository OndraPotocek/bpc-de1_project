library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity an_sel is
    Port(sig_digit : in STD_LOGIC;
       an !: out STD_LOGIC_VECTOR(7 downto 0)
    );
end an_sel;

architecture Behavioral of an_sel is

    begin
        if sig_digit = '0' then
            an <= "11111110";
        else
            an <= "11101111";
        end if;
        
end Behavioral;