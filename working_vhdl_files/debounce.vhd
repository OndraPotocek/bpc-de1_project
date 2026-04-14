
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debounce is
    Port ( clk           : in STD_LOGIC;
           rst           : in STD_LOGIC;
           btn_in        : in STD_LOGIC;
           btn_state     : out STD_LOGIC;
           btn_press     : out STD_LOGIC);
end debounce;

architecture Behavioral of debounce is
    ----------------------------------------------------------------
    -- Constants
    ----------------------------------------------------------------
    constant C_SHIFT_LEN : positive := 4;  -- kolik jedniček nebo nul musi byt za sebou -- 4 stačí, většina tlačítek se tak ošetří
    constant C_MAX       : positive := 200_000;  -- Sampling period, jka často se ty 4 samply budou brát, jak rychle se bude samplovat
                                           -- 2 for simulation
                                           -- 200_000 (2 ms) for implementation !!! 8 ms stabilní signál = sepnuto rozepnuto

    ----------------------------------------------------------------
    -- Internal signals
    ----------------------------------------------------------------
    signal ce_sample : std_logic;
    signal sync0     : std_logic;
    signal sync1     : std_logic;
    signal shift_reg : std_logic_vector(C_SHIFT_LEN-1 downto 0);
    signal debounced : std_logic;
    signal delayed   : std_logic;

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
    -- Synchronizer + debounce
    ----------------------------------------------------------------
    p_debounce : process(clk) -- vykonávají se sekvenčně
        -- ALE PŘIŘAZENÍ se naplní až po tom co je proces ukončen
    begin
        -- asynchronní reset TADY, ale toto je synchronní rst
        if rising_edge(clk) then -- řízeno náběžnou hranou
            if rst = '1' then
                sync0     <= '0';
                sync1     <= '0';
                shift_reg <= (others => '0');
                debounced <= '0';
                delayed   <= '0';

            else
                -- Input synchronizer
                sync1 <= sync0; -- syn0 se aktualizuje až na konci procesu, až na dlaší hraně náběžného signálu
                sync0 <= btn_in;

                -- Sample only when enable pulse occurs
                if ce_sample = '1' then -- pomocná proměnná

                    -- Shift values to the left and load a new sample as LSB
                    shift_reg <= shift_reg(C_SHIFT_LEN-2 downto 0) & sync1; -- & SPOJENÍ 2 PROMĚNNÝCH DO SEBE
                        -- zřetězování věktorů, bitů

                    -- Check if all bits are '1'
                    if shift_reg = (shift_reg'range => '1') then -- range ... vezme všechny bity v registru, nezávisle na jeho šířce
                        debounced <= '1';
                    -- Check if all bits are '0'
                    elsif shift_reg = (shift_reg'range => '0') then
                        debounced <= '0';
                    end if;

                end if;

                -- One clock delayed output
                delayed <= debounced; -- pomocný signál, 
            end if;
        end if;
    end process;

    ----------------------------------------------------------------
    -- Outputs
    ----------------------------------------------------------------
    btn_state <= debounced;
    -- One-clock pulse when button pressed
    btn_press <= debounced and not(delayed); -- AND ... druhý signál je znegovaný,
        -- NOT delayed and debounced

end Behavioral;
