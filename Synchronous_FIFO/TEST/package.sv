`ifndef FIFO_PACKAGE_UVM
`define FIFO_PACKAGE_UVM

`include "uvm_macros.svh"

package pkg;
	import uvm_pkg::*;
	parameter int DELAY = 20;
	static bit reset_flag;
	event reset_ev;
	`include "seq_item.sv"
	`include "sequencer.sv"
	`include "driver_callback_base.sv"
	`include "driver_callback_user.sv"
	`include "driver.sv"
	`include "monitor.sv"
	`include "agent.sv"
	`include "scoreboard.sv"
	`include "func_covg.sv"
	`include "env.sv"

	`include "base_sequence.sv"
	`include "write_seqs.sv"
	`include "read_seqs.sv"
	`include "simul_write_read_seqs.sv"

	`include "base_test.sv"
	`include "sanity_test.sv"
	`include "full_empty_full_empty_test.sv"
	`include "fullw_halfr_halfw_fullr_test.sv"
	`include "back_to_back_write_read_test.sv"
	`include "full_write_read_test.sv"
	`include "half_write_read_test.sv"
	`include "simul_write_read_test.sv"
	`include "overflow_callback_test.sv"
	`include "underflow_callback_test.sv"
	`include "overflow_underflow_callback_test.sv"
	`include "in_between_reset_test.sv"

endpackage

`endif
