library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
entity cpu is
port(reset : in std_logic;
 clk : in std_logic;
 rs_out, rt_out : out std_logic_vector(31 downto 0);
 pc_out : out std_logic_vector(31 downto 0); -- pc reg
 overflow, zero : out std_logic);
end cpu;

architecture rtl of cpu is 

-- Components
component next_address_32 is 
port(rt, rs : in std_logic_vector(31 downto 0);
 pc : in std_logic_vector(31 downto 0);
 target_address : in std_logic_vector(25 downto 0);
 branch_type : in std_logic_vector(1 downto 0);
 pc_sel : in std_logic_vector(1 downto 0);
 next_pc : out std_logic_vector(31 downto 0));
end component;

component pc_reg is
port(pc_in : in std_logic_vector(31 downto 0);
	reset : in std_logic;
 	clk : in std_logic;
 	pc_out : out std_logic_vector(31 downto 0));
end component;

component i_cache is
port( next_pc : in std_logic_vector (31 downto 0);
      next_inst : out std_logic_vector (31 downto 0));
end component;

component d_cache is
	port ( alu_result : in std_logic_vector(31 downto 0);
	d_in : std_logic_vector(31 downto 0);
	reset : in std_logic;
	data_write : in std_logic;
	clk : in std_logic;
	d_out : out std_logic_vector(31 downto 0));
end component;

component sign_extend is
port ( imm : in std_logic_vector (31 downto 0);
       func : in std_logic_vector (1 downto 0);
	output : out std_logic_vector (31 downto 0));
end component;

component regfile_32 is
port( din : in std_logic_vector(31 downto 0);
 reset : in std_logic;
 clk : in std_logic;
 write : in std_logic;
 read_a : in std_logic_vector(4 downto 0);
 read_b : in std_logic_vector(4 downto 0);
 write_address : in std_logic_vector(4 downto 0);
 out_a : out std_logic_vector(31 downto 0);
 out_b : out std_logic_vector(31 downto 0));
end component;

component alu is 
port(x,y : in std_logic_vector(31 downto 0);
logic_func, func : in std_logic_vector(1 downto 0);
add_sub : in std_logic;
output_out : out std_logic_vector(31 downto 0);
zero, overflow : out std_logic);
end component;

-- Signals to be used fo interconnections

signal sig1, sig2, sig3, sig4, sig5, sig6, sig7, sig8, sig9, sig10: std_logic_vector (31 downto 0);
-- signal s1 : std_logic_vector (25 downto 0);
signal sig11 : std_logic_vector (4 downto 0);
signal sig12, sig13, sig14, sig15 : std_logic_vector (1 downto 0);
signal sig16, sig17, sig18, sig19, sig20, sig21 :std_logic;
signal reset_sig, clk_sig : std_logic;
-- Using proper architectures for each component

for U1 : next_address_32 use entity work.next_address_32(rtl);
for U2 : pc_reg use entity work.pc_reg(rtl);
for U3 : i_cache use entity work.i_cache(rtl);
for U4 : sign_extend use entity work.sign_extend(rtl);
for U5 : regfile_32 use entity work.regfile_32(rtl);
for U6 : alu use entity work.alu(rtl);
for U7 : d_cache use entity work.d_cache(rtl);


begin

U1 : next_address_32 port map (rt => sig9, rs => sig8, pc => sig10, target_address => sig2 (25 downto 0), pc_sel => sig12, branch_type => sig13, next_pc => sig1);
U2 : pc_reg port map (pc_in => sig1, reset => reset_sig, clk => clk_sig, pc_out => sig10);
U3 : i_cache port map (next_pc => sig10, next_inst => sig2);
U4 : sign_extend port map (imm => sig2, func => sig14, output => sig3);
U5 : regfile_32 port map (din => sig7, reset => reset_sig, clk => clk_sig, write => sig16 , read_a =>sig2 (25 downto 21) , read_b => sig2 (20 downto 16), write_address => sig11 , out_a =>sig8 , out_b => sig9);
U6 : alu port map (x => sig8, y => sig4, add_sub => sig17, logic_func => sig15, func => sig14, output_out => sig5, overflow => overflow, zero => zero); 
U7 : d_cache port map (clk => clk_sig, reset => reset_sig, data_write => sig18, d_in => sig9, alu_result => sig5, d_out => sig6);

-- control unit
process (sig12, sig13, sig2, sig14, sig16, sig17, sig15, sig18, sig19, sig20, sig21)
begin 
 case sig2 (31 downto 26) is 
	-- opcode for r type
	when "000000" => 
	case sig2 (5 downto 0) is
		-- add
		when "100000" => 
					sig16 <= '1';						 					 			 									 
					sig19 <= '1';
					sig21 <= '1';
					sig20 <= '0';
					sig17 <= '0';
					sig18 <= '0';
					sig15 <= "00";
					sig14 <= "10";
					sig13 <= "00";
					sig12 <= "00";
		-- sub
		when "100010" => 
					sig16 <= '1';						 					 												
					sig19 <= '1';
					sig21 <= '1';
					sig20 <= '0';
					sig17 <= '1';
					sig18 <= '0';
					sig15 <= "00";
					sig14 <= "10";
					sig13 <= "00";
					sig12 <= "00";
		
		-- slt
		when "101010" => 
					sig16 <= '1';						 					 												
					sig19 <= '1';
					sig21 <= '1';
					sig20 <= '0';
					sig17 <= '0';
					sig18 <= '0';
					sig15 <= "00";
					sig14 <= "01";
					sig13 <= "00";
					sig12 <= "00";

		-- and
		when "100100" => 
					sig16 <= '1';						 					 												
					sig19 <= '1';
					sig21 <= '1';
					sig20 <= '0';
					sig17 <= '0';
					sig18 <= '0';
					sig15 <= "00";
					sig14 <= "11";
					sig13 <= "00";
					sig12 <= "00";

		-- or
		when "100101" => 
					sig16 <= '1';						 					 		 										
					sig19 <= '1';
					sig21 <= '1';
					sig20 <= '0';
					sig17 <= '0';
					sig18 <= '0';
					sig15 <= "01";
					sig14 <= "11";
					sig13 <= "00";
					sig12 <= "00";

		-- xor
		when "100110" => 
					sig16 <= '1';						 																	
					sig19 <= '1';
					sig21 <= '1';
					sig20 <= '0';
					sig17 <= '0';
					sig18 <= '0';
					sig15 <= "10";
					sig14 <= "11";
					sig13 <= "00";
					sig12 <= "00";

		-- nor
		when "100111" => 
					sig16 <= '1';						 																	
					sig19 <= '1';
					sig21 <= '1';
					sig20 <= '0';
					sig17 <= '0';
					sig18 <= '0';
					sig15 <= "11";
					sig14 <= "11";
					sig13 <= "00";
					sig12 <= "00";

		-- jr
		when "001000" => 
					sig16 <= '0';						 																	
					sig19 <= '0';
					sig21 <= '0';
					sig20 <= '0';
					sig17 <= '0';
					sig18 <= '0';
					sig15 <= "00";
					sig14 <= "00";
					sig13 <= "00";
					sig12 <= "10";
		when others => 
					sig16 <= '0';						 																	
					sig19 <= '0';
					sig21 <= '0';
					sig20 <= '0';
					sig17 <= '0';
					sig18 <= '0';
					sig15 <= "00";
					sig14 <= "00";
					sig13 <= "00";
					sig12 <= "00";			
		end case;
  
	-- i type instructions (first 6 bits)
  	when "001111" => 
			 sig16 <= '1';						 																	
			 sig19 <= '0';
			 sig21 <= '1';
			 sig20 <= '1';
			 sig17 <= '0';
			 sig18 <= '0';
			 sig15 <= "00";
			 sig14 <= "00";
			 sig13 <= "00";
			 sig12 <= "00";

  	when "001000" => 
		 	 sig16 <= '1';						 					 												
			 sig19 <= '0';
			 sig21 <= '1';
			 sig20 <= '1';
			 sig17 <= '0';
			 sig18 <= '0';
			 sig15 <= "00";
			 sig14 <= "10";
			 sig13 <= "00";
			 sig12 <= "00";

  	when "001010" => 
			 sig16 <= '1';						 					 												
			 sig19 <= '0';
			 sig21 <= '1';
			 sig20 <= '1';
			 sig17 <= '0';
			 sig18 <= '0';
			 sig15 <= "00";
			 sig14 <= "01";
			 sig13 <= "00";
			 sig12 <= "00";

  	when "001100" => 
			 sig16 <= '1';						 																	
			 sig19 <= '0';
			 sig21 <= '1';
			 sig20 <= '1';
			 sig17 <= '0';
			 sig18 <= '0';
			 sig15 <= "00";
			 sig14 <= "11";
			 sig13 <= "00";
			 sig12 <= "00";

  	when "001101" => 
			 sig16 <= '1';						 																	
			 sig19 <= '0';
			 sig21 <= '1';
			 sig20 <= '1';
			 sig17 <= '0';
			 sig18 <= '0';
			 sig15 <= "01";
			 sig14 <= "11";
			 sig13 <= "00";
			 sig12 <= "00";

  	when "001110" => 
			 sig16 <= '1';						 																	
			 sig19 <= '0';
			 sig21 <= '1';
			 sig20 <= '1';
			 sig17 <= '0';
			 sig18 <= '0';
			 sig15 <= "10";
			 sig14 <= "11";
			 sig13 <= "00";
			 sig12 <= "00";

  	when "100011" => 
			 sig16 <= '1';						 																	
			 sig19 <= '0';
			 sig21 <= '0';
			 sig20 <= '1';
			 sig17 <= '0';
			 sig18 <= '0';
			 sig15 <= "10";
			 sig14 <= "10";
			 sig13 <= "00";
			 sig12 <= "00";

  	when "101011" => 
			 sig16 <= '0';
			 sig19 <= '0';
			 sig21 <= '0';
			 sig20 <= '1';
			 sig17 <= '0';
			 sig18 <= '1';
			 sig15 <= "00";
			 sig14 <= "00";
			 sig13 <= "00";
			 sig12 <= "00";

	when "000010" => 
			 sig16 <= '0';
			 sig19 <= '0';
			 sig21 <= '0';
			 sig20 <= '0';
			 sig17 <= '0';
			 sig18 <= '0';
			 sig15 <= "00";
			 sig14 <= "00";
			 sig13 <= "00";
			 sig12 <= "01";

  	when "000001" => 
			 sig16 <= '0';						 																	
			 sig19 <= '0';
			 sig21 <= '0';
			 sig20 <= '0';
			 sig17 <= '0';
			 sig18 <= '0';
			 sig15 <= "00";
			 sig14 <= "00";
			 sig13 <= "11";
			 sig12 <= "00";

  	when "000100" => 
			 sig16 <= '0';						 																	
			 sig19 <= '0';
			 sig21 <= '0';
			 sig20 <= '0';
			 sig17 <= '0';
			 sig18 <= '0';
			 sig15 <= "00";
			 sig14 <= "00";
			 sig13 <= "01";
			 sig12 <= "00";

	when "000101" => 
			 sig16 <= '0';						 					 												
			 sig19 <= '0';
			 sig21 <= '0';
			 sig20 <= '0';
			 sig17 <= '0';
			 sig18 <= '0';
			 sig15 <= "00";
			 sig14 <= "00";
			 sig13 <= "10";
			 sig12 <= "00";

  	when others => 
			 sig16 <= '0';						 					 												
			 sig19 <= '0';
			 sig21 <= '0';
			 sig20 <= '0';
			 sig17 <= '0';
			 sig18 <= '0';
			 sig15 <= "00";
			 sig14 <= "00";
			 sig13 <= "00";
			 sig12 <= "00";
  end case;
end process;

-- All 3 multiplexers from left to right
-- reg_dst multiplexer
sig11 <= sig2 (20 downto 16) when sig19 = '0' else 
       sig2 (15 downto 11);

-- alu_src multiplexers
sig4 <= sig9 when sig20 = '0' else
      sig3;

-- reg_in_src multiplexers
sig7 <= sig6 when sig21 = '0' else 
       sig5;

reset_sig <= reset;
clk_sig <= clk;

-- Final output
rs_out <= sig8;
rt_out <= sig9;
pc_out <= sig10;

end rtl;