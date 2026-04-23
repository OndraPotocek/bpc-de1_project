library ieee;
use ieee.std_logic_1164.all;

entity tb_counter_1bit is
end tb_counter_1bit;

architecture tb of tb_counter_1bit is

    -- 1. Component Declaration
    component counter_1bit
        port (
            clk       : in  std_logic;
            rst       : in  std_logic;
            en        : in  std_logic;
            sig_digit : out std_logic
        );
    end component;

    -- 2. Testbench Signals
    signal clk       : std_logic := '0';
    signal rst       : std_logic := '0';
    signal en        : std_logic := '0';
    signal sig_digit : std_logic;

    constant TbPeriod : time := 10 ns;
    signal TbSimEnded : std_logic := '0';

begin

    -- 3. Instantiate the UUT
    dut : counter_1bit
    port map (
        clk       => clk,
        rst       => rst,
        en        => en,
        sig_digit => sig_digit
    );

    -- 4. Clock Generation Process
    clk_process : process
    begin
        while TbSimEnded = '0' loop
            clk <= '0';
            wait for TbPeriod/2;
            clk <= '1';
            wait for TbPeriod/2;
        end loop;
        wait;
    end process;

    -- 5. Stimuli Process
    stimuli : process
    begin
        -- Test A: Reset Initialization
        rst <= '1';
        en  <= '0';
        wait for 20 ns;
        
        rst <= '0';
        wait for 20 ns; -- Watch it do nothing while 'en' is 0

        -- Test B: Turn on Enable
        -- It should toggle its output on every rising edge of the clock now!
        en <= '1';
        wait for 60 ns; -- Watch it flip back and forth 6 times

        -- Test C: Pause (Disable)
        -- It should freeze and hold its current value (either 0 or 1)
        en <= '0';
        wait for 40 ns;

        -- Test D: Resume Toggling
        en <= '1';
        wait for 40 ns;

        -- Stop the clock and end the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;