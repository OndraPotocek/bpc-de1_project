library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Square wave generator with variable duty cycle
-- Output is 0 (low) or 255 (high) for PWM compatibility

entity sq_gen is
    Port ( cnt_in_sq  : in STD_LOGIC_VECTOR (7 downto 0);  -- Phase counter from counter module (0-255)
           duty_cyc   : in STD_LOGIC_VECTOR (1 downto 0);  -- Duty cycle select from sw(6:5)
           cnt_out_sq     : out STD_LOGIC_VECTOR (7 downto 0)  -- Square wave output (0 or 255)
         );
end sq_gen;

architecture Behavioral of sq_gen is

    -- Threshold constants for duty cycle comparison
    -- cnt_in_sq ranges 0-255, so we calculate threshold as 256 * duty_cycle_percent
    
    constant THRESH_25  : integer := 64;   -- 25% of 256
    constant THRESH_50  : integer := 128;  -- 50% of 256
    constant THRESH_75  : integer := 192;  -- 75% of 256
    constant THRESH_100 : integer := 256;  -- 100% (always high)

    -- Internal signals
    signal s_cnt    : integer range 0 to 255;   -- Phase counter as integer
    signal s_thresh : integer range 0 to 256;   -- Selected threshold as integer

begin

    -- Convert input std_logic_vector to integer
    s_cnt <= to_integer(unsigned(cnt_in_sq));

    -- Combinational process: select threshold based on duty_cyc input
    -- This runs whenever duty_cyc changes

    process (duty_cyc) is
    begin
    
        case duty_cyc is
        
            when "00" =>
                -- 25% duty cycle
                s_thresh <= THRESH_25;
                
            when "01" =>
                -- 50% duty cycle
                s_thresh <= THRESH_50;
                
            when "10" =>
                -- 75% duty cycle
                s_thresh <= THRESH_75;
                
            when "11" =>
                -- 100% duty cycle
                s_thresh <= THRESH_100;
                
            when others =>
                -- Default to 50% if undefined
                s_thresh <= THRESH_50;
                
        end case;
        
    end process;

    -- Generate square wave output
    -- HIGH (255) when counter is below threshold, LOW (0) otherwise
    -- This creates the duty cycle: (threshold / 256) * 100%

    cnt_out_sq <= "11111111" when s_cnt < s_thresh else "00000000";

end Behavioral;