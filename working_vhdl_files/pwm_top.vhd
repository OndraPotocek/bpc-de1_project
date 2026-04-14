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

architecture Behavioral of pwm_top is

    signal amplitude : STD_LOGIC_VECTOR(7 downto 0);
    signal pwm_out : STD_LOGIC;
    signal sig_saw : STD_LOGIC_VECTOR(7 downto 0);
    signal sig_sine : STD_LOGIC_VECTOR(7 downto 0);
    signal sig_sq : STD_LOGIC_VECTOR(7 downto 0);

    signal clk_en : STD_LOGIC;
    signal sig_btnu : STD_LOGIC;
    signal sig_btnl : STD_LOGIC;
    signal sig_btnr : STD_LOGIC;
    signal sig_endisp : STD_LOGIC;
    signal sig_bin : STD_LOGIC_VECTOR(3 downto 0);


    component pwm
        Port(clk : in STD_LOGIC; 
            amplitude : in STD_LOGIC_VECTOR(7 downto 0 );
            pwm_out : out STD_LOGIC
        );
    end component pwm

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
    end component debounce

    component counter
        Port(clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            en : in STD_LOGIC;
            cnt_out : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component counter

    component clk_en_wave
        Port(clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            sel_period : in STD_LOGIC;
            ce : out STD_LOGIC
        );
    end component clk_en_wave

    component latch
        Port(
            rst : in STD_LOGIC;
            catch_btnup : in STD_LOGIC;
            catch_btnleft : in STD_LOGIC;
            catch_btnright : in STD_LOGIC;
            holt_mux : out STD_LOGIC

        );
    end component latch

    component clk_en_disp
        generic(
            G_MAX : positive
        );
        Port(clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            ce_disp : out STD_LOGIC
        );
    end component clk_en_disp

    component pwm_mux
        Port(wav_sel : in STD_LOGIC_VECTOR(1 downto 0);
            sig_saw : in STD_LOGIC_VECTOR(7 downto 0);
            sig_sine : in STD_LOGIC_VECTOR(7 downto 0);
            sig_sq : in STD_LOGIC_VECTOR(7 downto 0);
            sig_out : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component pwm_mux

    component counter_1bit
        Port(clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            en : in STD_LOGIC;
            sig_digit : out STD_LOGIC
        );
    end component counter_1bit

    component an_sel
        Port(sig_digit : in STD_LOGIC;
            an : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component an_sel

    component bin2seg
        Port(bin : in STD_LOGIC_VECTOR(3 downto 0);
            seg : out STD_LOGIC_VECTOR(6 downto 0);
            
        );
    end component bin2seg

    component disp_mux
        Port(sig_digit : in STD_LOGIC;
            sw0 : in STD_LOGIC;
            sw1 : in STD_LOGIC;
            sig_bin : in STD_LOGIC_VECTOR(3 downto 0);
            seg : out STD_LOGIC_VECTOR(6 downto 0);
        );
    end component disp_mux

end pwm_top;