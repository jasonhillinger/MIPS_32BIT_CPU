library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity regfile_32 is
    port( din : in std_logic_vector(31 downto 0);
        reset : in std_logic;
        clk: in std_logic;
        write : in std_logic;
        read_a : in std_logic_vector(4 downto 0);
        read_b : in std_logic_vector(4 downto 0);
        write_address : in std_logic_vector(4 downto 0);
        out_a : out std_logic_vector(31 downto 0);
        out_b : out std_logic_vector(31 downto 0));
end regfile_32 ;


architecture rtl of regfile_32 is

    type register_array is array(0 to 31) of std_logic_vector(31 downto 0);
    signal registers : register_array;
    
    begin 
    
    --process for reset and write to registers
    process(write, clk, reset) is
        begin
        -- Async reset for registers
        if(reset = '1') then
            registers<=(others=>(others=>'0'));                

        elsif rising_edge(clk) and write = '1' then 
                registers(conv_integer(write_address)) <= din;
        end if;

    end process;
    
        out_a <= registers(conv_integer(read_a));
        out_b <= registers(conv_integer(read_b));

end architecture;