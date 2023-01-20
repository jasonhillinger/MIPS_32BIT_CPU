library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity sign_extend is
port ( imm : in std_logic_vector (31 downto 0);
       func : in std_logic_vector (1 downto 0);
	output : out std_logic_vector (31 downto 0));
end sign_extend;

architecture rtl of sign_extend is

begin
 process(imm, func)
  begin
   case func is 
	when "00" => output <= imm (15 downto 0) & "0000000000000000";	-- load upper
	when "01" => output <= (31 downto 16 => imm(15)) & imm (15 downto 0);	-- arithmetic sign extend and lower immediate
	when "10" => output <= (31 downto 16 => imm(15)) & imm (15 downto 0);	-- arithmetic sign extend and lower immediate
	when others => output <= "0000000000000000" & imm (15 downto 0); 		-- 16 zeros with lower immediate
   end case;
 end process;
end rtl;