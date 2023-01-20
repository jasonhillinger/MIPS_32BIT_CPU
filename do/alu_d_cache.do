add wave /sig5
add wave /sig6
add wave /reset
add wave /clk

force /reset 1
force /clk 0
run 2

examine -hex /sig5
force /reset 0
run 2
force /clk 1
 run 2
force /clk 0
run 2

examine -hex /sig5
force /clk 1 
 run 2
force /clk 0
run 2

examine -hex /sig5
force /clk 1 
 run 2
force /clk 0
run 2

force /clk 1 
 run 2
force /clk 0
run 2

force /clk 1 
 run 2
force /clk 0
run 2