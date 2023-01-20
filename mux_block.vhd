library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux_block is
    port(a , b, c, d : in std_logic_vector(31 downto 0);
        func : in std_logic_vector(1 downto 0);
        f : out std_logic_vector(31 downto 0)
    );
end mux_block;

architecture rtl of mux_block is

begin
    f <= a when func = "00" else
        b when func = "01" else
        c when func = "10" else
        d when func = "11" else 
        (others => 'Z');
end architecture;
