-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Tue, 21 Apr 2026 14:49:20 GMT
-- Request id : cfwk-fed377c2-69e78e7019e3a

library ieee;
use ieee.std_logic_1164.all;

entity tb_sq_gen is
end tb_sq_gen;

architecture tb of tb_sq_gen is

    component sq_gen
        port (cnt_in_sq  : in std_logic_vector (7 downto 0);
              duty_cyc   : in std_logic_vector (1 downto 0);
              cnt_out_sq : out std_logic_vector (7 downto 0));
    end component;

    signal cnt_in_sq  : std_logic_vector (7 downto 0);
    signal duty_cyc   : std_logic_vector (1 downto 0);
    signal cnt_out_sq : std_logic_vector (7 downto 0);

begin

    dut : sq_gen
    port map (cnt_in_sq  => cnt_in_sq,
              duty_cyc   => duty_cyc,
              cnt_out_sq => cnt_out_sq);

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        cnt_in_sq <= (others => '0');
        duty_cyc <= (others => '0');

        -- ***EDIT*** Add stimuli here

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_sq_gen of tb_sq_gen is
    for tb
    end for;
end cfg_tb_sq_gen;