library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pwm_top is
    Port(clk : in STD_LOGIC; 
        rst_btnc : in STD_LOGIC;
        sw : in STD_LOGIC_VECTOR(6 downto 0);
        btnu : in STD_LOGIC;
        btnl : in STD_LOGIC;
        btnr : in STD_LOGIC;

        AUD_pwm : out STD_LOGIC;
        AUD_sd : out STD_LOGIC;
        an : out STD_LOGIC_VECTOR(7 downto 0);
        seg : out STD_LOGIC_VECTOR(6 downto 0);
        dp : out STD_LOGIC
    );
end pwm_top;

architecture Behavioral of pwm_top is

    -- Internal signals
    signal amplitude : STD_LOGIC_VECTOR(7 downto 0);
    signal pwm_out_sig : STD_LOGIC;
    signal sig_saw : STD_LOGIC_VECTOR(7 downto 0);
    signal sig_sine : STD_LOGIC_VECTOR(7 downto 0);
    signal sig_sq : STD_LOGIC_VECTOR(7 downto 0);
    signal clk_en_wave : STD_LOGIC;
    signal sig_endisp : STD_LOGIC;
    signal sig_btnu : STD_LOGIC;
    signal sig_btnl : STD_LOGIC;
    signal sig_btnr : STD_LOGIC;
    signal sig_digit : STD_LOGIC;
    signal sig_bin : STD_LOGIC_VECTOR(3 downto 0);
    signal sig_pwm_mux : STD_LOGIC_VECTOR(7 downto 0);  -- From pwm_mux to pwm
    signal hold_mux : STD_LOGIC_VECTOR(1 downto 0);      -- From flip_flop to pwm_mux (waveform select)

    -- Component declarations

    component pwm
        Port(clk : in STD_LOGIC; 
            amplitude : in STD_LOGIC_VECTOR(7 downto 0);
            pwm_out : out STD_LOGIC
        );
    end component;

    component debounce
        Port(clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            btnu : in STD_LOGIC;
            btnl : in STD_LOGIC;
            btnr : in STD_LOGIC;
            btn_up_db : out STD_LOGIC;
            btn_left_db : out STD_LOGIC;
            btn_right_db : out STD_LOGIC
        );
    end component;

    component counter
        Port(clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            en : in STD_LOGIC;
            cnt_out : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component clk_en_wave
        Port(clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            sel_period : in STD_LOGIC;
            ce : out STD_LOGIC
        );
    end component;

    component flip_flop
        Port(
            rst : in STD_LOGIC;
            catch_btnup : in STD_LOGIC;
            catch_btnleft : in STD_LOGIC;
            catch_btnright : in STD_LOGIC;
            hold_mux : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

    component clk_en_disp
        generic(
            G_MAX : positive := 100_000
        );
        Port(clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            ce_disp : out STD_LOGIC
        );
    end component;

    component pwm_mux
        Port(
            wav_sel : in STD_LOGIC_VECTOR(1 downto 0);
            pwm_mux_saw : in STD_LOGIC_VECTOR(7 downto 0);
            pwm_mux_sq : in STD_LOGIC_VECTOR(7 downto 0);
            pwm_mux_sine : in STD_LOGIC_VECTOR(7 downto 0);
            pwm_mux_out : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component sq_gen
        Port(
            cnt_in_sq : in STD_LOGIC_VECTOR(7 downto 0);
            duty_cyc : in STD_LOGIC_VECTOR(1 downto 0);
            cnt_out_sq : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component sine_gen
        Port(
            cnt_in_sine : in STD_LOGIC_VECTOR(7 downto 0);
            cnt_out_sine : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component counter_1bit
        Port(clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            en : in STD_LOGIC;
            sig_digit : out STD_LOGIC
        );
    end component;

    component an_sel
        Port(sig_digit : in STD_LOGIC;
            an : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component bin2seg
        Port(bin : in STD_LOGIC_VECTOR(3 downto 0);
            seg : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

    component disp_mux
        Port(
            sig_dig : in STD_LOGIC;
            sw0 : in STD_LOGIC;
            sw1 : in STD_LOGIC;
            sig_bin : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

begin

    -- Clock enable for waveform generation (frequency control)
    clk_en_wave_inst : clk_en_wave
        port map(
            clk => clk,
            rst => rst_btnc,
            sel_period => sw(3),
            ce => clk_en_wave
        );

    -- Phase counter (sawtooth generator)
    counter_inst : counter
        port map(
            clk => clk,
            rst => rst_btnc,
            en => clk_en_wave,
            cnt_out => sig_saw
        );

    -- Square wave generator
    sq_gen_inst : sq_gen
        port map(
            cnt_in_sq => sig_saw,
            duty_cyc => sw(6 downto 5),
            cnt_out_sq => sig_sq
        );

    -- Sine wave generator
    sine_gen_inst : sine_gen
        port map(
            cnt_in_sine => sig_saw,
            cnt_out_sine => sig_sine
        );

    -- Waveform multiplexer
    pwm_mux_inst : pwm_mux
        port map(
            wav_sel => hold_mux,
            pwm_mux_saw => sig_saw,
            pwm_mux_sq => sig_sq,
            pwm_mux_sine => sig_sine,
            pwm_mux_out => sig_pwm_mux
        );

    -- PWM modulator
    pwm_inst : pwm
        port map(
            clk => clk,
            amplitude => sig_pwm_mux,
            pwm_out => pwm_out_sig
        );

    -- Audio outputs
    AUD_pwm <= pwm_out_sig;
    AUD_sd <= '1';

    -- Button debounce
    debounce_inst : debounce
        port map(
            clk => clk,
            rst => rst_btnc,
            btnu => btnu,
            btnl => btnl,
            btnr => btnr,
            btn_up_db => sig_btnu,
            btn_left_db => sig_btnl,
            btn_right_db => sig_btnr
        );

    -- Button state flip-flop (waveform selector)
    flip_flop_inst : flip_flop
        port map(
            rst => rst_btnc,
            catch_btnup => sig_btnu,
            catch_btnleft => sig_btnl,
            catch_btnright => sig_btnr,
            hold_mux => hold_mux
        );

    -- Display clock enable (100MHz / 100_000 = 1kHz for display refresh)
    clk_en_disp_inst : clk_en_disp
        generic map(
            G_MAX => 100_000
        )
        port map(
            clk => clk,
            rst => rst_btnc,
            ce_disp => sig_endisp
        );

    -- Display digit counter
    counter_1bit_inst : counter_1bit
        port map(
            clk => clk,
            rst => rst_btnc,
            en => sig_endisp,
            sig_digit => sig_digit
        );

    -- Anode selector for 7-seg display
    an_sel_inst : an_sel
        port map(
            sig_digit => sig_digit,
            an => an
        );

    -- Display multiplexer (selects what to show on 7-seg)
    disp_mux_inst : disp_mux
        port map(
            sig_dig => sig_digit,
            sw0 => sw(0),
            sw1 => sw(1),
            sig_bin => sig_bin
        );

    -- Binary to 7-segment decoder
    bin2seg_inst : bin2seg
        port map(
            bin => sig_bin,
            seg => seg
        );

    -- Decimal point (inactive)
    dp <= '1';

end Behavioral;
