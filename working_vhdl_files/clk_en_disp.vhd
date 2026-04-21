------------------------------------------------
--! @file clk_en_disp.vhd
--! @brief This code generates a clock enable signal for the display based on a specified maximum count value.
------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--! clk - Input clock signal
--! rst - Signal to reset the component
--! ce_disp - Clock enable signal for the display
--! G_MAX - Max count value before asserting the clock enable signal
entity clk_en_disp is
    generic (
        G_MAX : positive := 100_000
    );
    Port(clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        ce_disp : out STD_LOGIC;
    );
end clk_en_disp;

--
architecture Behavioral of clk_en_disp is
begin
    process(clk, rst)
        variable count : integer := 0;
    begin
        if rst = '1' then
            ce_disp <= '0';
            count := 0;
        elsif rising_edge(clk) then
            if count = G_MAX - 1 then
                ce_disp <= '1';
                count := 0;
            else
                ce_disp <= '0';
                count := count + 1;
            end if;
        end if;
    end process;
end