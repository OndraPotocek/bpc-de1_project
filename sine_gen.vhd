library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Sine wave generator using LUT (Look-Up Table)
-- 256 samples per period, 8-bit output (0-255, centered at 128)
-- Formula: round(127.5 * sin(2*pi*phase/256) + 127.5)

entity sine_gen is
    Port ( cnt_in_sine    : in STD_LOGIC_VECTOR (7 downto 0);
           cnt_out_sine   : out STD_LOGIC_VECTOR (7 downto 0)
         );
end sine_gen;

architecture Behavioral of sine_gen is

    type t_lut is array (0 to 255) of std_logic_vector(7 downto 0);
    
    constant SINE_LUT : t_lut := (

        -- 0° to ~22.5°
        x"80", x"83", x"86", x"89", x"8C", x"8F", x"92", x"95",
        x"98", x"9B", x"9E", x"A2", x"A5", x"A7", x"AA", x"AD",
        
        -- ~22.5° to ~45°
        x"B0", x"B3", x"B6", x"B9", x"BC", x"BE", x"C1", x"C4",
        x"C6", x"C9", x"CB", x"CE", x"D0", x"D3", x"D5", x"D7",
        
        -- ~45° to ~67.5°
        x"DA", x"DC", x"DE", x"E0", x"E2", x"E4", x"E6", x"E8",
        x"EA", x"EB", x"ED", x"EE", x"F0", x"F1", x"F3", x"F4",
        
        -- ~67.5° to 90° (approaching peak)
        x"F5", x"F6", x"F8", x"F9", x"FA", x"FA", x"FB", x"FC",
        x"FD", x"FD", x"FE", x"FE", x"FE", x"FF", x"FF", x"FF",
        
        --: 90° to ~112.5° (falling from peak)
        x"FF", x"FF", x"FF", x"FF", x"FE", x"FE", x"FE", x"FD",
        x"FD", x"FC", x"FB", x"FA", x"FA", x"F9", x"F8", x"F6",
        
        -- ~112.5° to ~135°
        x"F5", x"F4", x"F3", x"F1", x"F0", x"EE", x"ED", x"EB",
        x"EA", x"E8", x"E6", x"E4", x"E2", x"E0", x"DE", x"DC",
        
        -- ~135° to ~157.5°
        x"DA", x"D7", x"D5", x"D3", x"D0", x"CE", x"CB", x"C9",
        x"C6", x"C4", x"C1", x"BE", x"BC", x"B9", x"B6", x"B3",
        
        -- ~157.5° to 180°
        x"B0", x"AD", x"AA", x"A7", x"A5", x"A2", x"9E", x"9B",
        x"98", x"95", x"92", x"8F", x"8C", x"89", x"86", x"83",
        
        -- 180° to ~202.5°
        x"80", x"7C", x"79", x"76", x"73", x"70", x"6D", x"6A",
        x"67", x"64", x"61", x"5D", x"5A", x"58", x"55", x"52",
        
        -- ~202.5° to ~225°
        x"4F", x"4C", x"49", x"46", x"43", x"41", x"3E", x"3B",
        x"39", x"36", x"34", x"31", x"2F", x"2C", x"2A", x"28",
        
        -- ~225° to ~247.5°
        x"25", x"23", x"21", x"1F", x"1D", x"1B", x"19", x"17",
        x"15", x"14", x"12", x"11", x"0F", x"0E", x"0C", x"0B",
        
        -- ~247.5° to 270°
        x"0A", x"09", x"07", x"06", x"05", x"05", x"04", x"03",
        x"02", x"02", x"01", x"01", x"01", x"00", x"00", x"00",
        
        --: 270° to ~292.5°
        x"00", x"00", x"00", x"00", x"01", x"01", x"01", x"02",
        x"02", x"03", x"04", x"05", x"05", x"06", x"07", x"09",
        
        -- ~292.5° to ~315°
        x"0A", x"0B", x"0C", x"0E", x"0F", x"11", x"12", x"14",
        x"15", x"17", x"19", x"1B", x"1D", x"1F", x"21", x"23",
        
        -- ~315° to ~337.5°
        x"25", x"28", x"2A", x"2C", x"2F", x"31", x"34", x"36",
        x"39", x"3B", x"3E", x"41", x"43", x"46", x"49", x"4C",
        
        -- ~337.5° to 360°
        x"4F", x"52", x"55", x"58", x"5A", x"5D", x"61", x"64",
        x"67", x"6A", x"6D", x"70", x"73", x"76", x"79", x"7C"
    );

    signal s_idx : integer range 0 to 255;

begin

    s_idx <= to_integer(unsigned(cnt_in_sine));
    cnt_out_sine <= SINE_LUT(s_idx);

end Behavioral;