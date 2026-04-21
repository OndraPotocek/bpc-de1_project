library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity wave_latch is
    Port (
        clk            : in  STD_LOGIC;
        rst            : in  STD_LOGIC;
        catch_btnup    : in  STD_LOGIC;
        catch_btnleft  : in  STD_LOGIC; 
        catch_btnright : in  STD_LOGIC; 
        hold_mux       : out STD_LOGIC_VECTOR (1 downto 0)
    );
end wave_latch;

architecture Behavioral of wave_latch is
    signal state : STD_LOGIC_VECTOR(1 downto 0) := "00"; -- default state set to 00
begin

    process(clk)
    begin
        if rising_edge(clk) then -- synchronous wait
            if rst = '1' then
                state <= "00"; -- return to 00 if rst pressed
            elsif catch_btnleft = '1' then
                state <= "01"; -- 01 --> hold_mux state = SINE
            elsif catch_btnup = '1' then
                state <= "10"; -- 10 --> hold_mux state = SAW
            elsif catch_btnright = '1' then
                state <= "11"; -- 11 --> hold_mux state = SQUARE
                
            end if; -- NOTHING PRESSED --> remembers the current value 
        end if;
    end process;
    hold_mux <= state; -- outputs "state" to pin
end Behavioral;