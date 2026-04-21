--! Testbench automatically generated online
--! at https://vhdl.lapinoo.net
--! Generation date : Wed, 15 Apr 2026 21:55:09 GMT
--! Request id : cfwk-fed377c2-69e0093d0d0bb

library ieee;
use ieee.std_logic_1164.all;

entity tb_counter_1bit is
end tb_counter_1bit;

architecture tb of tb_counter_1bit is

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

    constant TbPeriod : time := 1000 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

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

        -- ***EDIT*** Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_counter_1bit of tb_counter_1bit is
    for tb
    end for;
end cfg_tb_counter_1bit;