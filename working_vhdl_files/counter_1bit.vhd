library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter_1bit is
Port(clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        en : in STD_LOGIC;
        sig_digit : out STD_LOGIC
    );
end counter_1bit;

architecture behavioral of counter_1bit is

begin
    process(clk, rst)
        variable count : integer := 0;
    begin
        if rst = '1' then
            sig_digit <= '0';
            count := 0;
        elsif rising_edge(clk) then
            if en = '1' then
                if count = 0 then
                    sig_digit <= '1';
                    count := 1;
                else
                    sig_digit <= '0';
                    count := 0;
                end if;
            end if;
        end if;
    end process;
end behavioral;