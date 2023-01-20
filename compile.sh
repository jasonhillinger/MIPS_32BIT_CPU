echo "Compiling VHDL files in proper order"
# source /CMC/ENVIRONMENT/modelsim.env
vcom adder_subtract.vhd mux_block.vhd logic_unit.vhd alu.vhd
vcom pc_reg.vhd regfile_32.vhd d_cache.vhd i_cache.vhd sign_extend.vhd next_address_32.vhd
vcom cpu.vhd
echo "End of compiling script!"
