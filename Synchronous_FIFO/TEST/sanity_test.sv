`ifndef FIFO_SANITY_TEST_UVM
`define FIFO_SANITY_TEST_UVM

class sanity_test extends base_test;

	//factory registration 
	`uvm_component_utils(sanity_test)

	//constructor 
	function new (string name = "sanity_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//instance of sequences 
	write_seqs write_h; 	//handle of write_seqs 
	read_seqs read_h;		//handle of read_seqs 

	//run phase
	//sanity test : single write read operation 
	task run_phase (uvm_phase phase);
		phase.raise_objection(this);
			
			//write operation to fifo 
			write_h = write_seqs::type_id::create("write_h");
			assert(write_h.randomize());
			write_h.start(env_h.agnt_h.seqr_h);

			//read operation from fifo 
			read_h = read_seqs::type_id::create("read_h");	
			assert(read_h.randomize());
			read_h.start(env_h.agnt_h.seqr_h);
		
			phase.phase_done.set_drain_time(this,40ns);
		phase.drop_objection(this);
	endtask

endclass

`endif 
