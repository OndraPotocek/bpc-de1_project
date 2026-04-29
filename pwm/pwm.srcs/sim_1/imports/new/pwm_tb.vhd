-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Sat, 25 Apr 2026 18:19:00 GMT
-- Request id : cfwk-fed377c2-69ed0594648af

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_pwm is
end tb_pwm;

architecture tb of tb_pwm is

    component pwm
        port (clk       : in std_logic;
              amplitude : in std_logic_vector (7 downto 0);
              pwm_out   : out std_logic);
    end component;

    signal clk       : std_logic;
    signal amplitude : std_logic_vector (7 downto 0);
    signal pwm_out   : std_logic;

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : pwm
    port map (clk       => clk,
              amplitude => amplitude,
              pwm_out   => pwm_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- Inicializace: zacneme s nulovou amplitudou
        amplitude <= (others => '0');
        wait for 500 ns; -- Vystup pwm_out by mel byt trvale '0'

        -- Test A: Amplituda 64 (Strida cca 25 %)
        amplitude <= std_logic_vector(to_unsigned(64, 8));
        wait for 10 us; 

        -- Test B: Amplituda 128 (Strida cca 50 %)
        amplitude <= std_logic_vector(to_unsigned(128, 8));
        wait for 10 us;

        -- Test C: Amplituda 192 (Strida cca 75 %)
        amplitude <= std_logic_vector(to_unsigned(192, 8));
        wait for 10 us;

        -- Test D: Amplituda 255 (Strida temer 100 %)
        amplitude <= std_logic_vector(to_unsigned(255, 8));
        wait for 10 us;

        -- Ukonceni simulace
        TbSimEnded <= '1';
        wait;
    end process;

end tb;


