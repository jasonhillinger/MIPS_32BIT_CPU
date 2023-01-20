add wave imm
add wave func
add wave output


force imm 00000000000000001100000000110101
force func 00
run 2

force imm 00000000000000001100000000110101
force func 01
run 2

force imm 00000000000000001100000000110101
force func 10
run 2

force imm 00000000000000001100000000110101
force func 11
run 2
