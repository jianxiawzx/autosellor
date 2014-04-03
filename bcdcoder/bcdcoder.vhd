library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity bcdcoder is
port(d:in std_logic_vector(3 downto 0);
q:out std_logic_vector(6 downto 0));
end bcdcoder;
architecture  one of bcdcoder is
begin
process(d)
begin
case d is
when"0000"=>q<="1111110";
when"0001"=>q<="0110000";
when"0010"=>q<="1101101";
when"0011"=>q<="1111001";
when"0100"=>q<="0110011";
when"0101"=>q<="1011011";
when"0110"=>q<="1011111";
when"0111"=>q<="1110000";
when"1000"=>q<="1111111";
when"1001"=>q<="1110011";
when others=>q<="0000000";
end case;
end process;
end one;
