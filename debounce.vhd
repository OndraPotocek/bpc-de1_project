library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debounce is
    Port ( clk           : in STD_LOGIC;
           rst           : in STD_LOGIC;
           btnu          : in STD_LOGIC;
           btnr          : in STD_LOGIC;
           btnl          : in STD_LOGIC;
           btn_up_db     : out STD_LOGIC;
           btn_left_db   : out STD_LOGIC;
           btn_right_db  : out STD_LOGIC
           );
end debounce;

architecture Behavioral of debounce is
    ----------------------------------------------------------------
    -- Constants
    ----------------------------------------------------------------
    constant C_SHIFT_LEN : positive := 4;  -- how many ones has to be there idk
    constant C_MAX       : positive := 200_000;  -- Sampling period

    ----------------------------------------------------------------
    -- Internal signals
    ----------------------------------------------------------------
    signal ce_sample : std_logic; -- 

    -- Signály pro tlačítko UP (nahoru)
    signal sync0_u, sync1_u         : std_logic; -- human presses button asynchronously, so we send the signal to sync0 first, then sync1 to make it OK
    signal shift_reg_u              : std_logic_vector(C_SHIFT_LEN-1 downto 0); -- more 1 after one another --> its pressed
    signal debounced_u  : std_logic; -- if '1111' --> outputs 1, if '0000' --> 0, is it pressed now
    signal delayed_u   : std_logic; -- last state, was it pressed before

    -- Signály pro tlačítko RIGHT (doprava)
    signal sync0_r, sync1_r         : std_logic;
    signal shift_reg_r              : std_logic_vector(C_SHIFT_LEN-1 downto 0);
    signal debounced_r              : std_logic;
    signal delayed_r   : std_logic;

    -- Signály pro tlačítko LEFT (doleva)
    signal sync0_l, sync1_l         : std_logic;
    signal shift_reg_l              : std_logic_vector(C_SHIFT_LEN-1 downto 0);
    signal debounced_l, delayed_l   : std_logic;

    ----------------------------------------------------------------
    -- Component declaration for clock enable
    ----------------------------------------------------------------
    component clk_en is
        generic ( G_MAX : positive );
        port (
            clk : in  std_logic;
            rst : in  std_logic;
            ce  : out std_logic
        );
    end component clk_en;

begin
    ----------------------------------------------------------------
    -- Clock enable instance
    ----------------------------------------------------------------
    clock_0 : clk_en
        generic map ( G_MAX => C_MAX )
        port map (
            clk => clk,
            rst => rst,
            ce  => ce_sample
        );

    ----------------------------------------------------------------
    -- Synchronizer + debounce logic
    ----------------------------------------------------------------
    p_debounce : process(clk) 
    begin
        if rising_edge(clk) then 
            if rst = '1' then
                -- Vynulování všech signálů pro všechna tlačítka
                sync0_u <= '0'; sync1_u <= '0'; shift_reg_u <= (others => '0'); debounced_u <= '0'; delayed_u <= '0';
                sync0_r <= '0'; sync1_r <= '0'; shift_reg_r <= (others => '0'); debounced_r <= '0'; delayed_r <= '0';
                sync0_l <= '0'; sync1_l <= '0'; shift_reg_l <= (others => '0'); debounced_l <= '0'; delayed_l <= '0';
            else
                -- 1. Input synchronizer (proti metastabilitě)
                sync1_u <= sync0_u; sync0_u <= btnu;
                sync1_r <= sync0_r; sync0_r <= btnr;
                sync1_l <= sync0_l; sync0_l <= btnl;

                -- 2. Samplování ve správný okamžik
                if ce_sample = '1' then 
                    
                    -- Tlačítko UP
                    shift_reg_u <= shift_reg_u(C_SHIFT_LEN-2 downto 0) & sync1_u;
                    if shift_reg_u = (shift_reg_u'range => '1') then debounced_u <= '1';
                    elsif shift_reg_u = (shift_reg_u'range => '0') then debounced_u <= '0'; end if;

                    -- Tlačítko RIGHT
                    shift_reg_r <= shift_reg_r(C_SHIFT_LEN-2 downto 0) & sync1_r;
                    if shift_reg_r = (shift_reg_r'range => '1') then debounced_r <= '1';
                    elsif shift_reg_r = (shift_reg_r'range => '0') then debounced_r <= '0'; end if;

                    -- Tlačítko LEFT
                    shift_reg_l <= shift_reg_l(C_SHIFT_LEN-2 downto 0) & sync1_l;
                    if shift_reg_l = (shift_reg_l'range => '1') then debounced_l <= '1';
                    elsif shift_reg_l = (shift_reg_l'range => '0') then debounced_l <= '0'; end if;

                end if;

                -- 3. Zpoždění pro detekci hrany (pulzu)
                delayed_u <= debounced_u;
                delayed_r <= debounced_r;
                delayed_l <= debounced_l;
                
            end if;
        end if;
    end process;

    ----------------------------------------------------------------
    -- Outputs
    ----------------------------------------------------------------
    btn_up_db    <= debounced_u and not(delayed_u);
    btn_right_db <= debounced_r and not(delayed_r);
    btn_left_db  <= debounced_l and not(delayed_l);

end Behavioral;