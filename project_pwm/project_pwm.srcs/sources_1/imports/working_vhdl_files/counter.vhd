library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- 8-bit phase accumulator counter
-- Increments on each enable pulse from clk_en_wave
entity counter is
    Port ( clk      : in STD_LOGIC;                     -- 100MHz system clock
           rst      : in STD_LOGIC;                     -- Active HIGH reset (1 = reset)
           en       : in STD_LOGIC;                     -- Clock enable from clk_en_wave
           cnt_out  : out STD_LOGIC_VECTOR (7 downto 0) -- 8-bit counter output (0-255)
         );
end counter;

architecture Behavioral of counter is

    -- Internal 8-bit counter signal
    signal s_cnt : integer range 0 to 255 := 0;

begin

    -- Main counter process
    process (clk) is
    begin
    
        -- Trigger on rising edge of clock
        if rising_edge(clk) then
        
            -- Check reset
            if rst = '1' then
                -- Clear counter to zero
                s_cnt <= 0;
                
            -- Only increment when enable pulse arrives
            elsif en = '1' then
                -- Add 1 to counter (wraps 255->0 automatically)
                s_cnt <= s_cnt + 1;
                
            end if;
            
        end if;
        
    end process;

    -- Convert to std_logic_vector for output
    cnt_out <= std_logic_vector(to_unsigned(s_cnt, 8));

end Behavioral;