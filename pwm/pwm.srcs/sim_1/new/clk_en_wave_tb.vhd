
library ieee;
use ieee.std_logic_1164.all;

entity tb_clk_en_wave is
end tb_clk_en_wave;

architecture tb of tb_clk_en_wave is

    component clk_en_wave
        port (clk        : in std_logic;
              rst        : in std_logic;
              sel_period : in std_logic_vector (3 downto 0);
              ce         : out std_logic);
    end component;

    signal clk        : std_logic;
    signal rst        : std_logic;
    signal sel_period : std_logic_vector (3 downto 0);
    signal ce         : std_logic;

    constant TbPeriod : time := 1000 ns; -- faster if we keep it as 1000 ns
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : clk_en_wave
    port map (clk        => clk,
              rst        => rst,
              sel_period => sel_period,
              ce         => ce);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- 1. Initialization and Reset
        sel_period <= "0000"; -- Start with the lowest pitch setting
        rst <= '1';
        wait for 5 * TbPeriod;
        rst <= '0';

        -- Test A: Let it run with sel_period = "0000" (s_max = 1953)
        -- We won't wait the full 1953 cycles, just long enough to see it counting
        wait for 20 * TbPeriod;

        -- Test B: Switch to the highest pitch setting "1111" (s_max = 48)
        -- We will wait long enough to see the 'ce' output pulse high at least twice!
        sel_period <= "1111";
        wait for 120 * TbPeriod; 

        -- Test C: Switch to a middle setting "1000" (s_max = 260)
        sel_period <= "1000";
        wait for 50 * TbPeriod;

        -- Test D: Hit reset while it is running to ensure it clears the counter
        rst <= '1';
        wait for 5 * TbPeriod;
        rst <= '0';
        wait for 10 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;
end tb;