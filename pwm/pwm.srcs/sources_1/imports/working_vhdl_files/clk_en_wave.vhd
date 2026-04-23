library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity clk_en_wave is
    Port ( clk        : in STD_LOGIC;
           rst        : in STD_LOGIC;
           sel_period : in STD_LOGIC_VECTOR (3 downto 0);
           ce         : out STD_LOGIC);
end clk_en_wave;

architecture Behavioral of clk_en_wave is

    -- Internal signals
    -- Counter capable of holding large values
    signal s_cnt : integer := 0;
    -- Variable to hold the dynamically selected maximum count value
    signal s_max : integer := 100_000;

begin

    process (sel_period) is
    begin
        case sel_period is
            -- Nízká čísla = Hluboké tóny (Nízká frekvence -> Vysoké s_max)
            when "0000" => s_max <= 1953; -- 200 Hz
            when "0001" => s_max <= 1302; -- 300 Hz
            when "0010" => s_max <= 976;  -- 400 Hz
            when "0011" => s_max <= 781;  -- 500 Hz
            
            -- Střední tóny
            when "0100" => s_max <= 651;  -- 600 Hz
            when "0101" => s_max <= 488;  -- 800 Hz
            when "0110" => s_max <= 390;  -- 1000 Hz (1 kHz)
            when "0111" => s_max <= 325;  -- 1200 Hz
            
            -- Vyšší tóny
            when "1000" => s_max <= 260;  -- 1500 Hz
            when "1001" => s_max <= 195;  -- 2000 Hz (2 kHz)
            when "1010" => s_max <= 156;  -- 2500 Hz
            when "1011" => s_max <= 130;  -- 3000 Hz
            
            -- Vysoké tóny (Vysoká frekvence -> Nízké s_max)
            when "1100" => s_max <= 97;   -- 4000 Hz
            when "1101" => s_max <= 78;   -- 5000 Hz
            when "1110" => s_max <= 65;   -- 6000 Hz
            when "1111" => s_max <= 48;   -- 8000 Hz (8 kHz)
            
            -- Pojistka (vrátíme se na základní tón 200 Hz)
            when others => s_max <= 1953; 
        end case;
    end process;


    -- Count clock pulses and generate a one-clock-cycle enable pulse
    process (clk) is
    begin
        if rising_edge(clk) then  -- Synchronous process
            if rst = '1' then     -- High-active reset
                ce    <= '0';     -- Reset output
                s_cnt <= 0;       -- Reset internal counter

            elsif s_cnt >= s_max - 1 then
                -- Set output pulse and reset internal counter
                ce    <= '1';
                s_cnt <= 0;
            else
                -- Clear output and increment internal counter
                ce    <= '0';
                s_cnt <= s_cnt + 1;
            end if;  -- End if for reset/check
        end if;      -- End if for rising_edge
    end process;

end Behavioral;