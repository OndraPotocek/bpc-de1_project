
-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Tue, 21 Apr 2026 14:48:23 GMT
-- Request id : cfwk-fed377c2-69e78e37325d6

library ieee;
use ieee.std_logic_1164.all;

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
        -- ***EDIT*** Adapt initialization as needed
        pwm_mux_saw <= (others => '0');
        pwm_mux_sq <= (others => '0');
        pwm_mux_sine <= (others => '0');
        wav_sel <= (others => '0');

        -- ***EDIT*** Add stimuli here

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_pwm_mux of tb_pwm_mux is
    for tb
    end for;
end cfg_tb_pwm_mux;