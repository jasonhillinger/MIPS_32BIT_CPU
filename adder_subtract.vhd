library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder_subtract is
    port(a , b : in std_logic_vector(31 downto 0);
        add_sub : in std_logic;
        f : out std_logic_vector(31 downto 0)
        -- MSB : out std_logic_vector(31 downto 0)
    );
end adder_subtract;

architecture rtl of adder_subtract is

signal output_f : std_logic_vector(31 downto 0);
begin
    output_f <= (a + b) when add_sub = '0' else
        (a - b) when add_sub = '1' else 
        (others => 'Z');
    -- MSB <= a - b;
    f <= output_f;
end architecture;
