library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity logic_unit is
    port(a_in , b_in : in std_logic_vector(31 downto 0);
        logic_func : in std_logic_vector(1 downto 0);
        f : out std_logic_vector(31 downto 0)
    );
end logic_unit;

architecture rtl of logic_unit is

begin
    f <= (a_in AND b_in) when logic_func = "00" else
        (a_in OR b_in) when logic_func = "01" else 
        (a_in XOR b_in) when logic_func = "10" else
        (a_in NOR b_in) when logic_func = "11" else
        (others => 'Z');
end architecture;