library ieee;
use ieee.std_logic_1164.all;

entity tb_counter is
end tb_counter;

architecture tb of tb_counter is

    -- 1. Declare the component (Notice we include the generic block!)
    component counter
        generic (
            G_BITS : positive
        );
        port (
            clk : in  std_logic;
            rst : in  std_logic;
            en  : in  std_logic;
            cnt : out std_logic_vector(G_BITS - 1 downto 0)
        );
    end component;

    -- Define the size we want to test (4 bits = counts 0 to 15)
    constant C_BITS : positive := 4;

    -- 2. Create fake wires
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal en  : std_logic := '0';
    signal cnt : std_logic_vector(C_BITS - 1 downto 0);

    constant TbPeriod : time := 10 ns;
    signal TbSimEnded : std_logic := '0';

begin

    -- 3. Instantiate the UUT and MAP THE GENERIC SIZE
    dut : counter
    generic map (
        G_BITS => C_BITS
    )
    port map (
        clk => clk,
        rst => rst,
        en  => en,
        cnt => cnt
    );

    -- 4. Clock generation
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

    -- 5. The Stimuli Process
    stimuli : process
    begin
        -- Test A: Initialization and Reset
        en <= '0';
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 10 ns;

        -- Test B: Enable Counting
        en <= '1';
        wait for 50 ns; -- Watch it count up 5 steps

        -- Test C: Pause Counting (Disable)
        en <= '0';
        wait for 30 ns; -- Watch it hold its value perfectly still

        -- Test D: Wrap-around test
        en <= '1';
        wait for 150 ns; -- Let it count past 15 to see it snap back to 0

        -- Test E: Synchronous Reset test (Press reset while it's running)
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        
        wait for 50 ns;

        -- Stop the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;