library ieee;
use ieee.std_logic_1164.all;

entity tb_bin2seg is
end tb_bin2seg;

architecture tb of tb_bin2seg is

    component bin2seg
        port (bin : in std_logic_vector (3 downto 0);
              seg : out std_logic_vector (6 downto 0));
    end component;

    signal bin : std_logic_vector (3 downto 0);
    signal seg : std_logic_vector (6 downto 0);

begin

    dut : bin2seg
    port map (bin => bin,
              seg => seg);

stimuli : process
    begin
        -- Test 0
        bin <= x"0";
        wait for 50 ns;

        -- Test 1
        bin <= x"1";
        wait for 50 ns;

        -- Test 5
        bin <= x"5";
        wait for 50 ns;

        -- Test 8 (All segments ON - this is how we know it is Active Low!)
        bin <= x"8";
        wait for 50 ns;

        -- Test A
        bin <= x"A";
        wait for 50 ns;

        -- Test F
        bin <= x"F";
        wait for 50 ns;

        -- Stop simulation
        wait;
    end process;

end tb;