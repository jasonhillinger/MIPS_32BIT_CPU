library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity alu is
    port (
        x,y : in std_logic_vector(31 downto 0);
        logic_func, func : in std_logic_vector(1 downto 0);
        add_sub : in std_logic;
        output_out : out std_logic_vector(31 downto 0);
        zero, overflow : out std_logic
    );
end alu;

architecture rtl of alu is

signal MSB_sig, adder_subtract_output, logic_unit_out : std_logic_vector(31 downto 0);


component adder_subtract
    port(a , b : in std_logic_vector(31 downto 0);
        add_sub : in std_logic;
        f : out std_logic_vector(31 downto 0)
        -- MSB : out std_logic_vector(31 downto 0)
    );
end component;

component mux_block
    port(a ,b, c, d : in std_logic_vector(31 downto 0);
        func : in std_logic_vector(1 downto 0);
        f : out std_logic_vector(31 downto 0)
    );
end component;

component logic_unit
    port(a_in , b_in : in std_logic_vector(31 downto 0);
        logic_func : in std_logic_vector(1 downto 0);
        f : out std_logic_vector(31 downto 0)
    );
end component;

for u1: adder_subtract use entity WORK.adder_subtract(rtl);
for u2: mux_block use entity WORK.mux_block(rtl);
for u3: logic_unit use entity WORK.logic_unit(rtl);

begin
    u1 : adder_subtract port map(a => x, b => y, add_sub => add_sub, f => adder_subtract_output);
    u2 : mux_block port map(a => y, b => MSB_sig, c => adder_subtract_output , d => logic_unit_out, func => func, f => output_out);
    u3 : logic_unit port map(a_in => x, b_in => y, logic_func => logic_func , f => logic_unit_out);

    zero <= '1' when adder_subtract_output = "00000000000000000000000000000000" else
            '0';
	
	MSB_sig <= (31 downto 1	=> '0', others => adder_subtract_output(31));
            
    -- overflow <= '1' when ( ( ( not x(31) ) AND ( not y(31) ) AND MSB_sig(0) ) OR (x(31) and y(31) and (not MSB_sig(0)) )) = '1' else '0';     
    overflow <= '1' when (((not x(31)) AND (not y(31)) AND MSB_sig(0) AND (not add_sub)) OR ((not x(31)) AND y(31) AND MSB_sig(0) AND add_sub) OR ((not x(31)) AND y(31) AND MSB_sig(0) AND (not add_sub)) OR (x(31) AND y(31) AND (not MSB_sig(0)) AND (not add_sub))) = '1' else '0';


end architecture;
