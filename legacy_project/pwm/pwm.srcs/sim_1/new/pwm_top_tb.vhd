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

    -- FIXED: 10 ns period for a true 100 MHz clock!
    constant TbPeriod : time := 10 ns; 
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
    clk <= TbClock;

    stimuli : process
    begin
        -- 1. Initialize Inputs
        sw <= (others => '0');
        btnu <= '0'; 
        btnl <= '0'; 
        btnr <= '0';

        -- 2. Master Reset
        rst_btnc <= '1';
        wait for 100 ns;
        rst_btnc <= '0';
        wait for 500 ns;

        -- ======================================================
        -- TEST A: Sawtooth Wave (UP Button)
        -- ======================================================
        -- We MUST hold the button for 3 ms to beat the 2 ms debouncer!
        btnu <= '1';
        wait for 3 ms; 
        btnu <= '0';
        
        -- Let the sawtooth wave play for a while at the lowest pitch
        wait for 5 ms; 


        -- ======================================================
        -- TEST B: Sine Wave (LEFT Button) + Higher Pitch
        -- ======================================================
        sw(3 downto 0) <= "0110"; -- Change pitch to 1 kHz
        
        btnl <= '1';
        wait for 3 ms; -- Hold to pass debouncer
        btnl <= '0';
        
        -- Let the sine wave play for a while at the new pitch
        wait for 5 ms;


        -- ======================================================
        -- TEST C: Square Wave (RIGHT Button) + 75% Duty Cycle
        -- ======================================================
        sw(6 downto 5) <= "10";   -- Set duty cycle to 75%
        sw(3 downto 0) <= "1111"; -- Set pitch to 8 kHz
        
        btnr <= '1';
        wait for 3 ms; -- Hold to pass debouncer
        btnr <= '0';
        
        -- Let the square wave play for a while
        wait for 5 ms;

        -- End the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;