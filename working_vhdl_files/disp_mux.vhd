library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity disp_mux is
    Port(sig_dig : in STD_LOGIC;
        sw0 : in STD_LOGIC_vector(3 downto 0);
        sw1 : in STD_LOGIC_VECTOR(1 downto 0);
        sig_bin : out STD_LOGIC_VECTOR(3 downto 0);
    );
end disp_mux;

architecture Behavioral of disp_mux is

begin
    process(sig_dig, sw0, sw1, sig_bin)
    begin
        switch (sig_dig) is
            when '0' =>
                sig_bin <= sw0;
            when '1' =>
                sig_bin <= sw1 & "0000";
            when others =>
                sig_bin <= "0000";
        end switch;
    end process;
end Behavioral;