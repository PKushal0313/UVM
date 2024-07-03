vlib work
vlog ../RTL/design.v ../TEST/package.sv ../TOP/top.sv +incdir+../ENV +incdir+../TEST
vsim -voptargs=+acc work.top +UVM_TESTNAME=${1}
add wave -r /*
run -all 
