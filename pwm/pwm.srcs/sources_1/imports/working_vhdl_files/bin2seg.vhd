-----------------------------------------------
--! @file bin2seg.vhd
--! @brief This code takes a 4-bit binary input and outputs the corresponding 7-segment display pattern.
------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--! bin - 4-bit binary input representing a hexadecimal digit (0-F)
--! seg - 7-bit output for the 7-segment display (a-g)
entity bin2seg is
    Port ( bin : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end bin2seg;

--! @brief The architecture defines a process that decodes the 4-bit binary input into the corresponding 7-segment display pattern.
architecture Behavioral of bin2seg is

begin

p_7seg_decoder : process (bin) is
begin
    case bin is
        when x"0" =>
            seg <= b"000_0001"; -- ekvivalentni zapis
        when x"1" => -- zaúis v hexadecimalni
            seg <= b"100_1111";
        when x"2" =>
            seg <= "0010010";
        when x"3" =>
            seg <= "0000110";
        when x"4" =>
            seg <= "1001100";
        when x"5" =>
            seg <= "0100100";
        when x"6" =>
            seg <= "0100000";
        when x"7" =>
            seg <= "0001111";
        when x"8" =>
            seg <= "0000000";
        when x"9" =>
            seg <= "0000100";
        when x"A" =>
            seg <= "0001000";
        when x"b" =>
            seg <= "1100000";
        when x"C" =>
            seg <= "0110001";
        when x"d" =>
            seg <= "1000010";
        when x"E" =>
            seg <= "0110000";
        when x"F" =>
            seg <= "0111000";

        -- Default case (e.g., for undefined values)
        when others =>
            seg <= "0111000";
    end case;
end process p_7seg_decoder;end Behavioral;


-- procesy= část kodu co se vykona pokud dojde ke zmene procesu v kulatych zavorkach