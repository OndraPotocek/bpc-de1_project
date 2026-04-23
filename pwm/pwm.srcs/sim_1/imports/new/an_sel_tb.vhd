
library ieee;
use ieee.std_logic_1164.all;

entity tb_an_sel is
end tb_an_sel;

architecture tb of tb_an_sel is

    component an_sel
        port (sig_digit : in std_logic;
              an        : out std_logic_vector (7 downto 0));
    end component;

    signal sig_digit : std_logic;
    signal an        : std_logic_vector (7 downto 0);

begin

    dut : an_sel
    port map (sig_digit => sig_digit,
              an        => an);

    stimuli : process
    begin
        -- Test A: Set digit to 0 (Should turn on the right-most digit)
        sig_digit <= '0';
        wait for 100 ns; 
        
        -- Test B: Set digit to 1 (Should turn on the 5th digit)
        sig_digit <= '1';
        wait for 100 ns; 

        -- Test C: Flip it back to 0
        sig_digit <= '0';
        wait for 100 ns;
        
        -- Test D: Flip it back to 1
        sig_digit <= '1';
        wait for 100 ns;

        -- Stop the simulation
        wait;
    end process;

end tb;