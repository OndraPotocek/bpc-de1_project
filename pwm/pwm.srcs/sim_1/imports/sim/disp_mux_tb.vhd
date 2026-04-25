-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Thu, 16 Apr 2026 07:20:05 GMT
-- Request id : cfwk-fed377c2-69e08da509220

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

begin

    dut : disp_mux
    port map (sig_dig => sig_dig,
              sw0     => sw0,
              sw1     => sw1,
              bin     => bin);

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        sw0 <= "0000";
        sw1 <= "00";
        wait for 10 ns;
        sig_dig <= '0';
        --sw0 <= (others => '0');
        --sw1 <= (others => '0');
        wait for 50 ns;
        sw0 <= "0101";
        sw1 <= "10";
        wait for 10 ns;
        sig_dig <= '1';
        wait for 50 ns;
        sw1 <= "01";
        wait for 10 ns;
        sw0 <= "0000";
        wait for 20 ns;
        sig_dig <= '0';
        wait for 10 ns;
        sw0 <= "1000";
        sw1 <= "11";
        wait for 10 ns;
        sig_dig <= '0';
                
        
        
        wait for 300 ns;

        -- ***EDIT*** Add stimuli here

        wait;
    end process;

end tb;
