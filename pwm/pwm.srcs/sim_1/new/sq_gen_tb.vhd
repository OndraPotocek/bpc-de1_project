library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- We need this library to do math in our for loop!

entity tb_sq_gen is
end tb_sq_gen;

architecture tb of tb_sq_gen is

    component sq_gen
        port (cnt_in_sq  : in std_logic_vector (7 downto 0);
              duty_cyc   : in std_logic_vector (1 downto 0);
              cnt_out_sq : out std_logic_vector (7 downto 0));
    end component;

    signal cnt_in_sq  : std_logic_vector (7 downto 0);
    signal duty_cyc   : std_logic_vector (1 downto 0);
    signal cnt_out_sq : std_logic_vector (7 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    dut : sq_gen
    port map (cnt_in_sq  => cnt_in_sq,
              duty_cyc   => duty_cyc,
              cnt_out_sq => cnt_out_sq);

    -- The Stimuli Process
    stimuli : process
    begin
        
        -- Test A: 25% Duty Cycle
        -- We set the duty cycle to "00", then use a loop to simulate the counter going 0 to 255
        duty_cyc <= "00";
        for i in 0 to 255 loop
            -- Convert the integer 'i' into an 8-bit binary vector
            cnt_in_sq <= std_logic_vector(to_unsigned(i, 8));
            wait for 10 ns; 
        end loop;

        -- Test B: 50% Duty Cycle
        duty_cyc <= "01";
        for i in 0 to 255 loop
            cnt_in_sq <= std_logic_vector(to_unsigned(i, 8));
            wait for 10 ns;
        end loop;

        -- Test C: 75% Duty Cycle
        duty_cyc <= "10";
        for i in 0 to 255 loop
            cnt_in_sq <= std_logic_vector(to_unsigned(i, 8));
            wait for 10 ns;
        end loop;

        -- Test D: 100% Duty Cycle
        duty_cyc <= "11";
        for i in 0 to 255 loop
            cnt_in_sq <= std_logic_vector(to_unsigned(i, 8));
            wait for 10 ns;
        end loop;

        -- Stop simulation
        wait;
    end process;

end tb;