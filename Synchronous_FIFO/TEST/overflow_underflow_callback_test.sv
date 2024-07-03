`ifndef FIFO_OVERFLOW_UNDERFLOW_CALLBACK_TEST_UVM 
`define FIFO_OVERFLOW_UNDERFLOW_CALLBACK_TEST_UVM 

class overflow_underflow_callback_test extends base_test;

	//factory registration 
	`uvm_component_utils(overflow_underflow_callback_test)

	//constructor 
	function new(string name = "overflow_underflow_callback_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//instance of sequences and callback driver 
	write_seqs write_h; 	//handle of write_seqs 
	read_seqs read_h;		//handle of read_seqs 
	driver_callback_user drv_cb_h; 		//handle of driver_callback_user 
	
	//build_phase : to create a handle of driver_callback_user 
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);	
		drv_cb_h = new("drv_cb_h");  	//create a object of driver_callback_user 
	endfunction

	//run phase : to check overflow and underflow flag check 
	task run_phase (uvm_phase phase);
		phase.raise_objection(this);
		
			//add method of uvm callbacks to connect driver and driver_callback 
			uvm_callbacks#(driver,driver_callback_base)::add(env_h.agnt_h.drv_h,drv_cb_h);

			//write operation to fifo 
			write_h = write_seqs::type_id::create("write_h");
			assert(write_h.randomize() with {write_h.no_of_trans == 18;});
			write_h.start(env_h.agnt_h.seqr_h);

			//read operation from fifo 
			read_h = read_seqs::type_id::create("read_h");	
			assert(read_h.randomize() with {read_h.no_of_trans == 18;});
			read_h.start(env_h.agnt_h.seqr_h);
	
			phase.phase_done.set_drain_time(this,40ns);
		phase.drop_objection(this);
	endtask

endclass

`endif 
