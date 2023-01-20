library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity  cpu_4bit  is
port(reset : in std_logic;
     clk   : in std_logic;
     rs_out, rt_out : out std_logic_vector(3 downto 0); -- output ports from reg. file
     pc_out : out std_logic_vector(3 downto 0);
     overflow, zero : out std_logic); 
end cpu_4bit;

architecture rtl of cpu_4bit is
    component cpu is
    port(reset : in std_logic;
    clk : in std_logic;
    rs_out, rt_out : out std_logic_vector(31 downto 0);
    pc_out : out std_logic_vector(31 downto 0); -- pc reg
    overflow, zero : out std_logic);
    end component;

    for U10 : cpu use entity work.cpu(rtl);
    signal rs_out_sig, rt_out_sig, pc_out_sig : std_logic_vector(31 downto 0);


begin

    U10 : cpu port map(reset => reset, clk => clk, rs_out => rs_out_sig, rt_out => rt_out_sig, pc_out => pc_out_sig, overflow => overflow, zero => zero);

    rs_out <= rs_out_sig(3 downto 0);
    rt_out <= rt_out_sig(3 downto 0);
    pc_out <= pc_out_sig(3 downto 0);

end rtl ; -- rtl


