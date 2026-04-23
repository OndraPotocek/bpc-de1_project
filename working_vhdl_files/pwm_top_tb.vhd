-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Thu, 23 Apr 2026 06:55:12 GMT
-- Request id : cfwk-fed377c2-69e9c25056387

library ieee;
use ieee.std_logic_1164.all;

entity tb_pwm_top is
end tb_pwm_top;

architecture tb of tb_pwm_top is

    component pwm_top
        port (clk      : in std_logic;
              rst_btnc : in std_logic;
              sw       : in std_logic_vector (6 downto 0);
              btnu     : in std_logic;
              btnl     : in std_logic;
              btnr     : in std_logic;
              AUD_pwm  : out std_logic;
              AUD_sd   : out std_logic;
              an       : out std_logic_vector (7 downto 0);
              seg      : out std_logic_vector (6 downto 0);
              dp       : out std_logic);
    end component;

    signal clk      : std_logic;
    signal rst_btnc : std_logic;
    signal sw       : std_logic_vector (6 downto 0);
    signal btnu     : std_logic;
    signal btnl     : std_logic;
    signal btnr     : std_logic;
    signal AUD_pwm  : std_logic;
    signal AUD_sd   : std_logic;
    signal an       : std_logic_vector (7 downto 0);
    signal seg      : std_logic_vector (6 downto 0);
    signal dp       : std_logic;

    constant TbPeriod : time := 1000 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : pwm_top
    port map (clk      => clk,
              rst_btnc => rst_btnc,
              sw       => sw,
              btnu     => btnu,
              btnl     => btnl,
              btnr     => btnr,
              AUD_pwm  => AUD_pwm,
              AUD_sd   => AUD_sd,
              an       => an,
              seg      => seg,
              dp       => dp);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
begin
    -- 1. Initialize Inputs
    sw <= (others => '0');
    btnu <= '0'; btnl <= '0'; btnr <= '0';

    rst_btnc <= '1';
    wait for 100 ns;
    rst_btnc <= '0';
    wait for 200 ns;

    btnu <= '1';
    wait for 20 ns; 
    btnu <= '0';
    wait for 1 ms; 
    btnl <= '1';
    wait for 20 ns;
    btnl <= '0';
    wait for 1 ms;

    -- Set sw(1 downto 0) for display mux
    sw <= "1101011"; 
    wait for 2 ms; 

    TbSimEnded <= '1';
    wait;
end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_pwm_top of tb_pwm_top is
    for tb
    end for;
end cfg_tb_pwm_top;
