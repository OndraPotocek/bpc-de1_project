<<<<<<< HEAD
--! Testbench automatically generated online
--! at https://vhdl.lapinoo.net
--! Generation date : Wed, 15 Apr 2026 21:55:09 GMT
--! Request id : cfwk-fed377c2-69e0093d0d0bb

=======
>>>>>>> c2be35fc6ae893bf3220b8eacd5352958af01845
library ieee;
use ieee.std_logic_1164.all;

entity tb_counter_1bit is
end tb_counter_1bit;

architecture tb of tb_counter_1bit is

<<<<<<< HEAD
    component counter_1bit
        port (clk       : in std_logic;
              rst       : in std_logic;
              en        : in std_logic;
              sig_digit : out std_logic);
    end component;

    signal clk       : std_logic;
    signal rst       : std_logic;
    signal en        : std_logic;
    signal sig_digit : std_logic;

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
=======
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
>>>>>>> c2be35fc6ae893bf3220b8eacd5352958af01845
    signal TbSimEnded : std_logic := '0';

begin

<<<<<<< HEAD
    dut : counter_1bit
    port map (clk       => clk,
              rst       => rst,
              en        => en,
              sig_digit => sig_digit);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        en <= '0';

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;
        
        en <= '1';
        wait for 100 ns;
        
        en <= '0';
        wait for 100 ns;
        
        en <= '1';
        wait for 500 ns;
        
        en <= '0';
        
        wait for 300 ns;
        
        en <= '1';
        
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
=======
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
>>>>>>> c2be35fc6ae893bf3220b8eacd5352958af01845
        TbSimEnded <= '1';
        wait;
    end process;

<<<<<<< HEAD
end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_counter_1bit of tb_counter_1bit is
    for tb
    end for;
end cfg_tb_counter_1bit;
=======
end tb;
>>>>>>> c2be35fc6ae893bf3220b8eacd5352958af01845
