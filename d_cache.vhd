library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; 
use ieee.numeric_std.all;

entity d_cache is 
port ( alu_result : in std_logic_vector(31 downto 0);
d_in : std_logic_vector(31 downto 0);
reset : in std_logic;
data_write : in std_logic;
clk : in std_logic;
d_out : out std_logic_vector(31 downto 0));
end d_cache;

architecture rtl of d_cache is

type cache_array is array(0 to 31) of std_logic_vector(31 downto 0);
signal cache : cache_array;
signal bad_result : std_logic_vector(31 downto 0) := (others => 'Z');

begin
process(data_write ,alu_result,clk, d_in, reset)
begin
    if(reset = '1') then
        cache<=(others=>(others=>'0'));    
    elsif(data_write = '1' and rising_edge(clk)) then
        cache(conv_integer(alu_result)) <= d_in;
    end if;
end process;

-- d_out <= cache(2);
-- process(alu_result)
-- begin
--     if to_integer(unsigned(alu_result)) < 33 then 
d_out <= cache(to_integer(unsigned(alu_result(4 downto 0))));
--     else 
--         d_out <= "11111111111111111111111111111111";
--     end if;
-- end process;


end rtl;