`ifndef FIFO_BASE_TEST_UVM
`define FIFO_BASE_TEST_UVM

class base_test extends uvm_test;

	//factory registration
	`uvm_component_utils(base_test)

	//constructor
	function new (string name = "base_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//handle of environment 
	env env_h;

	//build phase : To create components 
	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		env_h = env::type_id::create("env_h",this);
	endfunction

endclass

`endif
