
-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Tue, 21 Apr 2026 14:49:40 GMT
-- Request id : cfwk-fed377c2-69e78e84102ed

library ieee;
use ieee.std_logic_1164.all;

entity tb_sine_gen is
end tb_sine_gen;

architecture tb of tb_sine_gen is

    component sine_gen
        port (cnt_in_sine  : in std_logic_vector (7 downto 0);
              cnt_out_sine : out std_logic_vector (7 downto 0));
    end component;

    signal cnt_in_sine  : std_logic_vector (7 downto 0);
    signal cnt_out_sine : std_logic_vector (7 downto 0);

begin

    dut : sine_gen
    port map (cnt_in_sine  => cnt_in_sine,
              cnt_out_sine => cnt_out_sine);

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        cnt_in_sine <= (others => '0');

        -- ***EDIT*** Add stimuli here

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_sine_gen of tb_sine_gen is
    for tb
    end for;
end cfg_tb_sine_gen;