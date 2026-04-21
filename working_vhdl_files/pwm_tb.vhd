
-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Tue, 21 Apr 2026 14:48:58 GMT
-- Request id : cfwk-fed377c2-69e78e5adaac2

library ieee;
use ieee.std_logic_1164.all;

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

    constant TbPeriod : time := 1000 ns; -- ***EDIT*** Put right period here
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
        -- ***EDIT*** Adapt initialization as needed
        amplitude <= (others => '0');

        -- ***EDIT*** Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_pwm of tb_pwm is
    for tb
    end for;
end cfg_tb_pwm;