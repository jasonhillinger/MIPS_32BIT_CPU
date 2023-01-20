add wave alu_result
add wave d_in
add wave reset
add wave data_write
add wave clk
add wave d_out
add wave cache


force alu_result 00000000000000000000000000000000
force d_in 00000000000000000000000000000001
force reset 0
force data_write 0
force clk 0
run 1

force alu_result 00000000000000000000000000000000
force d_in 00000000000000000000000000000001
force reset 0
force data_write 0
force clk 1
run 1

force alu_result 00000000000000000000000000000000
force d_in 00000000000000000000000000000010
force reset 1
force data_write 0
force clk 0
run 1

force alu_result 00000000000000000000000000000000
force d_in 00000000000000000000000000000010
force reset 0
force data_write 1
force clk 1
run 1

force alu_result 00000000000000000000000000000010
force d_in 00000000000000000000000000000100
force reset 0
force data_write 1
force clk 0
run 1

force alu_result 00000000000000000000000000000010
force d_in 00000000000000000000000000000100
force reset 0
force data_write 1
force clk 1
run 1

force alu_result 00000000000000000000000000000000
force d_in 00000000000000000000000000000000
force reset 0
force data_write 0
force clk 0
run 1

force alu_result 00000000000000000000000000000000
force d_in 00000000000000000000000000000000
force reset 0
force data_write 0
force clk 1
run 1

