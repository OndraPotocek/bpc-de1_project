library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity disp_mux is
    Port(sig_dig : in STD_LOGIC;
        sw0 : in STD_LOGIC;
        sw1 : in STD_LOGIC;
        sig_bin : in STD_LOGIC_VECTOR(3 downto 0);
    );
end disp_mux;

architecture Behavioral of disp_mux is

end Behavioral;