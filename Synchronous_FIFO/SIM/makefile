regress: vlib vlog sim cover delete
vlib:
	vlib work
vlog:
	vlog -coveropt 3 +acc +cover ../RTL/design.v ../TEST/package.sv ../TOP/top.sv +incdir+../ENV +incdir+../TEST

sim:
	vsim -vopt -coverage top +UVM_TESTNAME=sanity_test -c -do "coverage save -onexit -directive -cvg -codeall test1.ucdb; run -all; exit"
	vsim -vopt -coverage top +UVM_TESTNAME=full_empty_full_empty_test -c -do "coverage save -onexit -directive -cvg -codeall test2.ucdb; run -all; exit"
	vsim -vopt -coverage top +UVM_TESTNAME=fullw_halfr_halfw_fullr_test -c -do "coverage save -onexit -directive -cvg -codeall test3.ucdb; run -all; exit"
	vsim -vopt -coverage top +UVM_TESTNAME=back_to_back_write_read_test -c -do "coverage save -onexit -directive -cvg -codeall test4.ucdb; run -all; exit"
	vsim -vopt -coverage top +UVM_TESTNAME=full_write_read_test -c -do "coverage save -onexit -directive -cvg -codeall test5.ucdb; run -all; exit"
	vsim -vopt -coverage top +UVM_TESTNAME=half_write_read_test -c -do "coverage save -onexit -directive -cvg -codeall test6.ucdb; run -all; exit"
	vsim -vopt -coverage top +UVM_TESTNAME=simul_write_read_test -c -do "coverage save -onexit -directive -cvg -codeall test7.ucdb; run -all; exit"
	vsim -vopt -coverage top +UVM_TESTNAME=overflow_callback_test -c -do "coverage save -onexit -directive -cvg -codeall test8.ucdb; run -all; exit"
	vsim -vopt -coverage top +UVM_TESTNAME=underflow_callback_test -c -do "coverage save -onexit -directive -cvg -codeall test9.ucdb; run -all; exit"
	vsim -vopt -coverage top +UVM_TESTNAME=overflow_underflow_callback_test -c -do "coverage save -onexit -directive -cvg -codeall test10.ucdb; run -all; exit"

cover:	
	vcover merge fifo.ucdb test1.ucdb test2.ucdb test3.ucdb test4.ucdb test5.ucdb test6.ucdb test7.ucdb test8.ucdb test9.ucdb test10.ucdb

delete:	 
	del test1.ucdb test2.ucdb test3.ucdb test4.ucdb test5.ucdb test6.ucdb test7.ucdb test8.ucdb test9.ucdb test10.ucdb
	vcover report -html -details fifo.ucdb -htmldir FIFO_TESTs


