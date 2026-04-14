library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_en_disp is
    generic (
        G_MAX : positive := 100_000
    );
    Port(clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        ce_disp : out STD_LOGIC;
    );
end clk_en_disp;

architecture Behavioral of clk_en_disp is
    signal cnt : integer range 0 to G_MAX := 0;
begin
   
end