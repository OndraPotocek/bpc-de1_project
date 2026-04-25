-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Sat, 25 Apr 2026 14:55:29 GMT
-- Request id : cfwk-fed377c2-69ecd5e13e4a5

library ieee;
use ieee.std_logic_1164.all;

entity tb_pwm_top is
end tb_pwm_top;

architecture tb of tb_pwm_top is

    component pwm_top
        port (clk          : in std_logic;
              rst_btnc     : in std_logic;
              sw           : in std_logic_vector (6 downto 0);
              btnu         : in std_logic;
              btnl         : in std_logic;
              btnr         : in std_logic;
              AUD_pwm      : out std_logic;
              AUD_sd       : out std_logic;
              an           : out std_logic_vector (7 downto 0);
              seg          : out std_logic_vector (6 downto 0);
              dp           : out std_logic;
              oscilloscope : out std_logic);
    end component;

    signal clk          : std_logic;
    signal rst_btnc     : std_logic;
    signal sw           : std_logic_vector (6 downto 0);
    signal btnu         : std_logic;
    signal btnl         : std_logic;
    signal btnr         : std_logic;
    signal AUD_pwm      : std_logic;
    signal AUD_sd       : std_logic;
    signal an           : std_logic_vector (7 downto 0);
    signal seg          : std_logic_vector (6 downto 0);
    signal dp           : std_logic;
    signal oscilloscope : std_logic;

    constant TbPeriod : time := 10 ns;
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : pwm_top
    port map (clk          => clk,
              rst_btnc     => rst_btnc,
              sw           => sw,
              btnu         => btnu,
              btnl         => btnl,
              btnr         => btnr,
              AUD_pwm      => AUD_pwm,
              AUD_sd       => AUD_sd,
              an           => an,
              seg          => seg,
              dp           => dp,
              oscilloscope => oscilloscope);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- 1. Inicializace vstupů
        sw <= (others => '0');
        btnu <= '0';
        btnl <= '0';
        btnr <= '0';

        -- 2. Reset
        rst_btnc <= '1';
        wait for 100 ns;
        rst_btnc <= '0';
        -- Po resetu je stav "00" -> PILA
        wait for 5 ms; 

        -- 3. TEST Sinus
        sw(3 downto 0) <= "0110";
        btnl <= '1';
        wait for 3 ms; -- Držíme déle než 2ms debouncer (snad)
        btnl <= '0';
        wait for 10 ms;

        -- 4. TEST Pila
        sw(3 downto 0) <= "1000";
        btnu <= '1';
        wait for 3 ms;
        btnu <= '0';
        wait for 10 ms;

        -- 5. TEST Obdélník
        sw(6 downto 5) <= "10";   -- střídy na 75%
        sw(3 downto 0) <= "1111";
        btnr <= '1';
        wait for 3 ms;
        btnr <= '0';
        wait for 10 ms;

        -- 6. Ukončení simulace
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

configuration cfg_tb_pwm_top of tb_pwm_top is
    for tb
    end for;
end cfg_tb_pwm_top;
