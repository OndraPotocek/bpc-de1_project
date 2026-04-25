
library ieee;
use ieee.std_logic_1164.all;

entity tb_flip_flop is
end tb_flip_flop;

architecture tb of tb_flip_flop is

    component flip_flop
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

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : flip_flop
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
        -- 1. Initialization
        catch_btnup <= '0';
        catch_btnleft <= '0';
        catch_btnright <= '0';

        -- 2. Reset generation (Clears the system to "00")
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;

        -- 3. THE STIMULI (Simulating button presses)
        
        -- Test A: Press Left Button (Expect state to become "01")
        catch_btnleft <= '1';
        wait for 3 * TbPeriod;  -- Hold button down for 3 clock cycles
        catch_btnleft <= '0';   -- Release button
        wait for 10 * TbPeriod; -- Wait and observe it holding "01"

        -- Test B: Press Up Button (Expect state to become "10")
        catch_btnup <= '1';
        wait for 3 * TbPeriod;
        catch_btnup <= '0';
        wait for 10 * TbPeriod; -- Wait and observe it holding "10"

        -- Test C: Press Right Button (Expect state to become "11")
        catch_btnright <= '1';
        wait for 3 * TbPeriod;
        catch_btnright <= '0';
        wait for 10 * TbPeriod; -- Wait and observe it holding "11"

        -- Test D: Priority Test (What happens if user mashes two buttons?)
        -- Since catch_btnleft is higher up in your if/elsif chain, it should win.
        catch_btnleft <= '1';
        catch_btnright <= '1';
        wait for 3 * TbPeriod;
        catch_btnleft <= '0';
        catch_btnright <= '0';
        wait for 10 * TbPeriod;

        -- Test E: Hardware Reset while a wave is playing
        rst <= '1';
        wait for 3 * TbPeriod;
        rst <= '0';

        wait for 20 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;
end tb;
