library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity pc_reg is
port(   pc_in : in std_logic_vector(31 downto 0);
	reset : in std_logic;
 	clk : in std_logic;
 	pc_out : out std_logic_vector(31 downto 0));
end pc_reg ;

architecture rtl of pc_reg is 

begin

process (clk, reset, pc_in) is 
 begin
	if reset = '1' then 
	 pc_out <= "00000000000000000000000000000000";
	elsif(rising_edge(clk)) then 
	   pc_out <= pc_in;
	end if; 
end process; 
end rtl; 