--! Testbench automatically generated online
--! at https://vhdl.lapinoo.net
--! Generation date : Wed, 15 Apr 2026 21:56:18 GMT
--! Request id : cfwk-fed377c2-69e0098262968

library ieee;
use ieee.std_logic_1164.all;

entity tb_disp_mux is
end tb_disp_mux;

architecture tb of tb_disp_mux is

    component disp_mux
        port (sig_dig : in std_logic;
              sw0     : in std_logic_vector (3 downto 0);
              sw1     : in std_logic_vector (1 downto 0);
              bin     : out std_logic_vector (3 downto 0));
    end component;

    signal sig_dig : std_logic;
    signal sw0     : std_logic_vector (3 downto 0);
    signal sw1     : std_logic_vector (1 downto 0);
    signal bin     : std_logic_vector (3 downto 0);

    constant TbPeriod : time := 1000 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : disp_mux
    port map (sig_dig => sig_dig,
              sw0     => sw0,
              sw1     => sw1,
              bin     => bin);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    --  ***EDIT*** Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    --  YOURCLOCKSIGNAL <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        sig_dig <= '0';
        sw0 <= (others => '0');
        sw1 <= (others => '0');

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

configuration cfg_tb_disp_mux of tb_disp_mux is
    for tb
    end for;
end cfg_tb_disp_mux;