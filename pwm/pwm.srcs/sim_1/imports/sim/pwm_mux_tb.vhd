
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tb_pwm_mux is
end tb_pwm_mux;

architecture tb of tb_pwm_mux is

    component pwm_mux
        port (pwm_mux_saw  : in std_logic_vector (7 downto 0);
              pwm_mux_sq   : in std_logic_vector (7 downto 0);
              pwm_mux_sine : in std_logic_vector (7 downto 0);
              wav_sel      : in std_logic_vector (1 downto 0);
              pwm_mux_out  : out std_logic_vector (7 downto 0));
    end component;

    signal pwm_mux_saw  : std_logic_vector (7 downto 0);
    signal pwm_mux_sq   : std_logic_vector (7 downto 0);
    signal pwm_mux_sine : std_logic_vector (7 downto 0);
    signal wav_sel      : std_logic_vector (1 downto 0);
    signal pwm_mux_out  : std_logic_vector (7 downto 0);

begin

    dut : pwm_mux
    port map (pwm_mux_saw  => pwm_mux_saw,
              pwm_mux_sq   => pwm_mux_sq,
              pwm_mux_sine => pwm_mux_sine,
              wav_sel      => wav_sel,
              pwm_mux_out  => pwm_mux_out);

    stimuli : process
    begin
        --  ciselne hodnoty prevedene na vektory.
        pwm_mux_saw  <= std_logic_vector(to_unsigned(50, 8));  -- Pila = 50 (Hex: 32)
        pwm_mux_sq   <= std_logic_vector(to_unsigned(100, 8)); -- Obdelnik = 100 (Hex: 64)
        pwm_mux_sine <= std_logic_vector(to_unsigned(150, 8)); -- Sinus = 150 (Hex: 96)
        
        wait for 20 ns;

        -- Test A: Pila (Sawtooth)
        wav_sel <= "00";
        wait for 50 ns; -- Na vystupu pwm_mux_out by melo byt 50

        -- Test B: Obdelnik (Square)
        wav_sel <= "01";
        wait for 50 ns; -- Na vystupu by melo byt 100

        -- Test C: Sinus (Sine)
        wav_sel <= "10";
        wait for 50 ns; -- Na vystupu by melo byt 150

        -- Test D: Pojistka pro ostatni stavy
        wav_sel <= "11";
        wait for 50 ns; -- Na vystupu by melo byt opet 100

        wait;
    end process;

end tb;
