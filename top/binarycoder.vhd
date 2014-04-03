Library  ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity binarycoder is
port(                             
		b:in std_logic_vector(3 downto 0);
		bcd0:out std_logic_vector(3 downto 0);
        bcd1:out std_logic_vector(3 downto 0)
		);
end binarycoder;
architecture one of binarycoder is
begin
process(b)
begin
case b is
when"0000"=>bcd0<="0000";bcd1<="0000";
when"0001"=>bcd0<="0001";bcd1<="0000";
when"0010"=>bcd0<="0010";bcd1<="0000";
when"0011"=>bcd0<="0011";bcd1<="0000";
when"0100"=>bcd0<="0100";bcd1<="0000";
when"0101"=>bcd0<="0101";bcd1<="0000";
when"0110"=>bcd0<="0110";bcd1<="0000";
when"0111"=>bcd0<="0111";bcd1<="0000";
when"1000"=>bcd0<="1000";bcd1<="0000";
when"1001"=>bcd0<="1001";bcd1<="0000";
when"1010"=>bcd0<="0000";bcd1<="0001";
when"1011"=>bcd0<="0001";bcd1<="0001";
when"1100"=>bcd0<="0010";bcd1<="0001";
when"1101"=>bcd0<="0011";bcd1<="0001";
when"1110"=>bcd0<="0100";bcd1<="0001";
when"1111"=>bcd0<="0101";bcd1<="0001";
when others=>null;
end case;
end process;
end one;
