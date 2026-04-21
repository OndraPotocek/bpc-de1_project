--! Testbench automatically generated online
--! at https://vhdl.lapinoo.net
--! Generation date : Wed, 15 Apr 2026 21:57:04 GMT
--! Request id : cfwk-fed377c2-69e009b09b724

library ieee;
use ieee.std_logic_1164.all;

entity tb_an_sel is
end tb_an_sel;

architecture tb of tb_an_sel is

    component an_sel
        port (sig_digit : in std_logic);
    end component;

    signal sig_digit : std_logic;

    constant TbPeriod : time := 1000 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : an_sel
    port map (sig_digit => sig_digit);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    --  ***EDIT*** Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    --  YOURCLOCKSIGNAL <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        sig_digit <= '0';

        -- Reset generation
        --  ***EDIT*** Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
        YOURRESETSIGNAL <= '1';
        wait for 100 ns;
        YOURRESETSIGNAL <= '0';
        wait for 100 ns;

        -- ***EDIT*** Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_an_sel of tb_an_sel is
    for tb
    end for;
end cfg_tb_an_sel;