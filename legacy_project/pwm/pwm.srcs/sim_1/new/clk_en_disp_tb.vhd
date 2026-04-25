library ieee;
use ieee.std_logic_1164.all;

entity tb_clk_en_disp is
end tb_clk_en_disp;

architecture tb of tb_clk_en_disp is

    -- 1. Component Declaration
    component clk_en_disp
        generic (
            G_MAX : positive
        );
        port (
            clk     : in  std_logic;
            rst     : in  std_logic;
            ce_disp : out std_logic
        );
    end component;

    -- 2. Testbench Signals
    signal clk     : std_logic := '0';
    signal rst     : std_logic := '0';
    signal ce_disp : std_logic;

    -- Standard 10ns clock for Nexys A7
    constant TbPeriod : time := 10 ns;
    signal TbSimEnded : std_logic := '0';

    -- This overrides the 100,000 default so we can actually see it work!
    constant C_MAX_SIM : positive := 5;

begin

    -- 3. Instantiate the UUT
    dut : clk_en_disp
    generic map (
        G_MAX => C_MAX_SIM
    )
    port map (
        clk     => clk,
        rst     => rst,
        ce_disp => ce_disp
    );

    -- 4. Clock Generation Process
    clk_process : process
    begin
        while TbSimEnded = '0' loop
            clk <= '0';
            wait for TbPeriod/2;
            clk <= '1';
            wait for TbPeriod/2;
        end loop;
        wait;
    end process;

    -- 5. Stimuli Process
    stimuli : process
    begin
        -- Test A: Apply Reset
        rst <= '1';
        wait for 20 ns;
        
        -- Test B: Release Reset and let it count
        rst <= '0';
        
        -- Since C_MAX_SIM is 5, a pulse happens every 5 clock cycles (50 ns).
        -- Waiting 200 ns will let us watch exactly 4 pulses happen perfectly in rhythm!
        wait for 200 ns;

        -- Test C: Hit Reset again mid-count to ensure it kills the pulse
        rst <= '1';
        wait for 30 ns;

        -- Stop the clock and end the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;