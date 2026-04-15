library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- 8-bit PWM modulator
-- Converts amplitude to PWM signal at ~390kHz (100MHz/256)
entity pwm is
    Port ( clk        : in STD_LOGIC;
           amplitude  : in STD_LOGIC_VECTOR (7 downto 0);  -- 8-bit amplitude (0-255)
           pwm_out    : out STD_LOGIC);
end pwm;

architecture Behavioral of pwm is
    -- Fast counter for PWM carrier (100MHz / 256 = ~390kHz)
    signal s_cnt : unsigned(7 downto 0) := (others => '0');
    signal s_amp : unsigned(7 downto 0);
begin
    s_amp <= unsigned(amplitude);
    
    process (clk) is
    begin
        if rising_edge(clk) then
            -- Free-running counter at 100MHz
            s_cnt <= s_cnt + 1;
            
            -- PWM comparison: output high when counter < amplitude
            -- This creates duty cycle proportional to amplitude
            if s_cnt < s_amp then
                pwm_out <= '1';
            else
                pwm_out <= '0';
            end if;
        end if;
    end process;
end Behavioral;

