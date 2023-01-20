library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity next_address_32 is
port(rt, rs : in std_logic_vector(31 downto 0);
pc : in std_logic_vector(31 downto 0);
target_address : in std_logic_vector(25 downto 0);
branch_type : in std_logic_vector(1 downto 0);
pc_sel : in std_logic_vector(1 downto 0);
next_pc : out std_logic_vector(31 downto 0));
end next_address_32;

architecture rtl of next_address_32 is
signal temp: std_logic_vector (31 downto 0) := "00000000000000000000000000000001";
begin

process(pc_sel, branch_type, target_address, pc, rt, rs, temp)
begin
case pc_sel is
	when "00" => 
			case branch_type is
				when "00" => next_pc <= pc + temp;
		 
				when "01" => 
						if (rs=rt) then
						  
						  next_pc <= pc + temp + ((31 downto 16 => target_address(15)) & target_address (15 downto 0));
						else 
						
						  next_pc <= pc + temp;
						end if;
				when "10" =>	
						if(rs/=rt) then
						 
						  next_pc <= pc + temp + ((31 downto 16 => target_address(15)) & target_address (15 downto 0));
						else 
						
						  next_pc <= pc + temp;
						end if;
				when others =>
						if(rs<0) then
						 
						 next_pc <= pc + temp + ((31 downto 16 => target_address(15)) & target_address (15 downto 0));
						else 
						
						  next_pc <= pc + temp;
						end if;
			        end case;
						
	when "01" => next_pc <="000000" & target_address (25 downto 0);
	
	when "10" => next_pc <= rs;
	
	when others => next_pc <= pc + temp;
 end case;
end process;
end rtl;
 	      











 
