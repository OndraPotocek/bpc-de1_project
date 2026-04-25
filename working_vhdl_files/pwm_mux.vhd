library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- 3-to-1 multiplexer for waveform selection
-- Selects between Sawtooth, Square, and Sine
entity pwm_mux is
    Port ( 
        pwm_mux_saw   : in  STD_LOGIC_VECTOR (7 downto 0); -- Sawtooth from counter
        pwm_mux_sq    : in  STD_LOGIC_VECTOR (7 downto 0); -- Square from sq_gen
        pwm_mux_sine  : in  STD_LOGIC_VECTOR (7 downto 0); -- Sine from sine_gen
        wav_sel       : in  STD_LOGIC_VECTOR (1 downto 0);
        pwm_mux_out   : out STD_LOGIC_VECTOR (7 downto 0)
    );
end pwm_mux;

architecture Behavioral of pwm_mux is
    -- No internal signals needed if we mux the vectors directly
begin

    -- Select waveform based on wav_sel
    process (wav_sel, pwm_mux_saw, pwm_mux_sq, pwm_mux_sine) is
    begin
        case wav_sel is
            when "00" => 
                pwm_mux_out <= pwm_mux_sq;   -- Výchozí stav (Obdélník)
            when "10" => 
                pwm_mux_out <= pwm_mux_saw;   -- btnu (Horní) -> Pila
            when "11" => 
                pwm_mux_out <= pwm_mux_sq;    -- btnr (Pravé) -> Obdélník
            when "01" => 
                pwm_mux_out <= pwm_mux_sine;  -- btnl (Levé) -> Sinus
            when others => 
                pwm_mux_out <= pwm_mux_saw;
        end case;
    end process;

end Behavioral;
