-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Thu, 23 Apr 2026 07:13:25 GMT
-- Request id : cfwk-fed377c2-69e9c695a8dd2

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
        for i in 0 to 255 loop
            cnt_in_sine <= std_logic_vector(to_unsigned(i, 8));
            wait for 10 ns;
        end loop;

        wait;
    end process;

end tb;
