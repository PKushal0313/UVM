`ifndef FIFO_OVERFLOW_CALLBACK_TEST_UVM
`define FIFO_OVERFLOW_CALLBACK_TEST_UVM 

class overflow_callback_test extends base_test;

	//factory registration 
	`uvm_component_utils(overflow_callback_test)

	//constructor 
	function new(string name = "overflow_callback_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//instances of sequence and callback driver 
	driver_callback_user drv_cb_h; 		//handle of driver_callback_user 
	write_seqs write_h;		//handle of write_seqs 

	//build phase : to create the handle of driver_callback_user 
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		drv_cb_h = new("drv_cb_h");  	//create a object of driver_callback_user 
	endfunction

	//run phase : to check overflow flag 
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
			
			//write operation to fifo 
			write_h = write_seqs::type_id::create("write_h");
			//add method of uvm callbacks to connect driver and driver_callback 
			uvm_callbacks#(driver,driver_callback_base)::add(env_h.agnt_h.drv_h,drv_cb_h);
			assert(write_h.randomize() with {write_h.no_of_trans == 18;});
			write_h.start(env_h.agnt_h.seqr_h);
			
			phase.phase_done.set_drain_time(this,40ns);
		phase.drop_objection(this);
	endtask 

endclass 

`endif 
