    library ieee;
use ieee.std_logic_1164.all;

entity tb_wave_latch is
end tb_wave_latch;

architecture tb of tb_wave_latch is

    component wave_latch
        port (clk            : in std_logic;
              rst            : in std_logic;
              catch_btnup    : in std_logic;
              catch_btnleft  : in std_logic;
              catch_btnright : in std_logic;
              hold_mux       : out std_logic_vector (1 downto 0));
    end component;

    signal clk            : std_logic;
    signal rst            : std_logic;
    signal catch_btnup    : std_logic;
    signal catch_btnleft  : std_logic;
    signal catch_btnright : std_logic;
    signal hold_mux       : std_logic_vector (1 downto 0);

    constant TbPeriod : time := 1000 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : wave_latch
    port map (clk            => clk,
              rst            => rst,
              catch_btnup    => catch_btnup,
              catch_btnleft  => catch_btnleft,
              catch_btnright => catch_btnright,
              hold_mux       => hold_mux);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        catch_btnup <= '0';
        catch_btnleft <= '0';
        catch_btnright <= '0';

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

configuration cfg_tb_wave_latch of tb_wave_latch is
    for tb
    end for;
end cfg_tb_wave_latch;