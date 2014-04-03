Library  ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity control is
port(   clk: in std_logic;     --ʱ��                        
		start_select: in std_logic;
		end_select:in std_logic;
		
		coin1:in std_logic;    --Ͷ1Ԫ�ź�
		coin5:in std_logic;    --Ͷ5Ԫ�ź�
		coin10:in std_logic;   --Ͷ10Ԫ�ź�
		price1:in std_logic;   --1Ԫ��Ʒ
		price3:in std_logic;   --3Ԫ��Ʒ
		price4:in std_logic;   --4Ԫ��Ʒ
		price5:in std_logic;   --5Ԫ��Ʒ
		price6:in std_logic;   --6Ԫ��Ʒ
		timecnt:out std_logic_vector(3 downto 0);
		paid:out std_logic_vector(3 downto 0);--�Ѹ����
		needed:out std_logic_vector(3 downto 0);--����֧���Ľ��
		success:out std_logic; --���׳ɹ���־
		failure:out std_logic; --����ʧ�ܱ�־
		selling:out std_logic; --���ڽ���
		outmoney:out std_logic;--��������
		moneyout:out std_logic_vector(3 downto 0));--������
		
end control;
architecture behav of control is
type state_type is (sa,sb,s0,s1,s2,s3);--s0��ʾͶ��״̬,s1����״̬��s2������״̬��s3�˿�״̬
signal current_state :state_type:=s0; --��ǰ״̬
--signal q:integer range 0 to 10; --������
signal q:std_logic_vector(3 downto 0); --������
begin  
process(clk)
variable paidtemp:std_logic_vector(3 downto 0);
variable neededtemp: std_logic_vector(3 downto 0);
variable total:std_logic_vector(3 downto 0);
begin
	if clk'event and clk='1' then
		case current_state is
		   when sa=>
		       needed<="0000";
			   success<='0';
			   failure<='0';
			   selling<='0';
			   outmoney<='0';
			   moneyout<="0000";
			   paidtemp:="0000";
			   neededtemp:="0000";	
			   paid<="0000";
			   timecnt<="1010";
			   q<="1010";
		       if start_select='1' then 
		           current_state<=sb;
		       end if;
		   when sb=>
		        if price1='1' then
				   neededtemp:=neededtemp+1;
				end if;
				if price3='1' then
				    neededtemp:=neededtemp+3;
				end if;
				if price4='1' then
					neededtemp:=neededtemp+4;
		        end if;
				if price5='1' then
				   neededtemp:=neededtemp+5;
				end if;
				if price6='1' then
				   neededtemp:=neededtemp+6;
				end if;
				if end_select='1' then
		            current_state<=s0;
		            total:=neededtemp;
		        end if;
				needed<=neededtemp;
		   when s0 =>
			    q<=q-1;
		        if q=1 then
		            failure<='1';
		            current_state<=s3;
		        end if;
		         if coin1='1' then
		            q<="1010";
		            paidtemp:=paidtemp+1;
		            if neededtemp<=1 then
		                neededtemp:="0000";
		                selling<='1';
		                current_state<=s1;
		            else
		                current_state<=s0;
		                neededtemp:=neededtemp-1;
		            end if;
		         end if;
		         if coin5='1' then
		            q<="1010";
		            paidtemp:=paidtemp+5;
		            if neededtemp<=5 then
		                neededtemp:="0000";
		                selling<='1';
		                current_state<=s1;
		            else
		                neededtemp:=neededtemp-5;
		                current_state<=s0;
		            end if;
		         end if;
		         if coin10='1' then
		            q<="1010";
		            paidtemp:=paidtemp+10;
		            if neededtemp<=10 then
		                neededtemp:="0000";
		                selling<='1';
		                current_state<=s1;
		            else
		                neededtemp:=neededtemp-10;
		                current_state<=s0;
		            end if;
		         end if;
		         paid<=paidtemp;
		         needed<=neededtemp;
		         timecnt<=q;   
		   when s1=>
		         paid<=paidtemp;
		         selling<='0';
		         if total=paidtemp then 
		             success<='1';
		             paid<="0000";	
		             current_state<=sa;
		         else
		            outmoney<='1';
		            current_state<=s2;
		            moneyout<=paidtemp-total;
		         end if;
		   when s2=>
		         outmoney<='0';
			     moneyout<="0000";
			     paidtemp:="0000";
			     neededtemp:="0000";
			     paid<="0000";	
		         success<='1';
		         current_state<=sa;
		   when s3=>
		         failure<='0';
		         moneyout<=paidtemp;
		         outmoney<='1';
		         timecnt<="1010";
		         current_state<=sa;
		end case;
	end if; 
end process;
end behav;