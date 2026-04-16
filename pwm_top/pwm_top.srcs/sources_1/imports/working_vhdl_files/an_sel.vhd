------------------------------------------------
--! @file an_sel.vhd
--! @brief Selects anode for enabling corresponding 7-segment
------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--! sig_digit - Input for selecting which digit to enable
--! an - 8-bit output for controlling the anodes of the 7-segment display
entity an_sel is
    Port(sig_digit : in STD_LOGIC;
       an : out STD_LOGIC_VECTOR(7 downto 0)
    );
end an_sel;

architecture Behavioral of an_sel is

begin
    process(sig_digit)
    begin
        if sig_digit = '0' then
            an <= "11111110";
        else
            an <= "11101111";
        end if;
end process;
end Behavioral;