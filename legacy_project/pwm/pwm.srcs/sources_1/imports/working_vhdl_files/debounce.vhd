library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debounce is
    Port ( clk          : in STD_LOGIC;
           rst          : in STD_LOGIC;
           btnu         : in STD_LOGIC;
           btnr         : in STD_LOGIC;
           btnl         : in STD_LOGIC;
           btn_up_db    : out STD_LOGIC;
           btn_left_db  : out STD_LOGIC;
           btn_right_db : out STD_LOGIC
           );
end debounce;

architecture Behavioral of debounce is
    ----------------------------------------------------------------
    -- Constants
    ----------------------------------------------------------------
    constant C_SHIFT_LEN : positive := 4;      -- How many samples must be the same
    constant C_MAX       : positive := 200_000; -- Sampling period (2ms at 100MHz)

    ----------------------------------------------------------------
    -- Internal signals
    ----------------------------------------------------------------
    signal ce_sample : std_logic; 

    -- Signals for UP button
    signal sync0_u, sync1_u : std_logic; 
    signal shift_reg_u      : std_logic_vector(C_SHIFT_LEN-1 downto 0); 
    signal debounced_u      : std_logic; 
    signal delayed_u        : std_logic; 

    -- Signals for RIGHT button
    signal sync0_r, sync1_r : std_logic;
    signal shift_reg_r      : std_logic_vector(C_SHIFT_LEN-1 downto 0);
    signal debounced_r      : std_logic;
    signal delayed_r        : std_logic;

    -- Signals for LEFT button
    signal sync0_l, sync1_l : std_logic;
    signal shift_reg_l      : std_logic_vector(C_SHIFT_LEN-1 downto 0);
    signal debounced_l      : std_logic;
    signal delayed_l        : std_logic;

    ----------------------------------------------------------------
    -- Component declaration for clock enable (FIXED to clk_en_disp)
    ----------------------------------------------------------------
    component clk_en_disp is
        generic ( G_MAX : positive );
        port (
            clk     : in  std_logic;
            rst     : in  std_logic;
            ce_disp : out std_logic
        );
    end component clk_en_disp;

begin
    ----------------------------------------------------------------
    -- Clock enable instance (Generates a pulse every 2ms)
    ----------------------------------------------------------------
    clock_0 : clk_en_disp
        generic map ( G_MAX => C_MAX )
        port map (
            clk     => clk,
            rst     => rst,
            ce_disp => ce_sample
        );

    ----------------------------------------------------------------
    -- Synchronizer + debounce logic
    ----------------------------------------------------------------
    p_debounce : process(clk) 
    begin
        if rising_edge(clk) then 
            if rst = '1' then
                -- Reset all signals
                sync0_u <= '0'; sync1_u <= '0'; shift_reg_u <= (others => '0'); debounced_u <= '0'; delayed_u <= '0';
                sync0_r <= '0'; sync1_r <= '0'; shift_reg_r <= (others => '0'); debounced_r <= '0'; delayed_r <= '0';
                sync0_l <= '0'; sync1_l <= '0'; shift_reg_l <= (others => '0'); debounced_l <= '0'; delayed_l <= '0';
            else
                -- 1. Input synchronizer (Prevents metastability)
                sync1_u <= sync0_u; sync0_u <= btnu;
                sync1_r <= sync0_r; sync0_r <= btnr;
                sync1_l <= sync0_l; sync0_l <= btnl;

                -- 2. Sampling at the right moment
                if ce_sample = '1' then 
                    
                    -- UP Button
                    shift_reg_u <= shift_reg_u(C_SHIFT_LEN-2 downto 0) & sync1_u;
                    if shift_reg_u = (shift_reg_u'range => '1') then 
                        debounced_u <= '1';
                    elsif shift_reg_u = (shift_reg_u'range => '0') then 
                        debounced_u <= '0'; 
                    end if;

                    -- RIGHT Button
                    shift_reg_r <= shift_reg_r(C_SHIFT_LEN-2 downto 0) & sync1_r;
                    if shift_reg_r = (shift_reg_r'range => '1') then 
                        debounced_r <= '1';
                    elsif shift_reg_r = (shift_reg_r'range => '0') then 
                        debounced_r <= '0'; 
                    end if;

                    -- LEFT Button
                    shift_reg_l <= shift_reg_l(C_SHIFT_LEN-2 downto 0) & sync1_l;
                    if shift_reg_l = (shift_reg_l'range => '1') then 
                        debounced_l <= '1';
                    elsif shift_reg_l = (shift_reg_l'range => '0') then 
                        debounced_l <= '0'; 
                    end if;

                end if;

                -- 3. Edge detection delay (Pulse generation)
                delayed_u <= debounced_u;
                delayed_r <= debounced_r;
                delayed_l <= debounced_l;
                
            end if;
        end if;
    end process;

    ----------------------------------------------------------------
    -- Outputs (Generates exactly ONE high clock pulse per button press)
    ----------------------------------------------------------------
    btn_up_db    <= debounced_u and not delayed_u;
    btn_right_db <= debounced_r and not delayed_r;
    btn_left_db  <= debounced_l and not delayed_l;

end Behavioral;