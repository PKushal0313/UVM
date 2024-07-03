`ifndef FULL_EMPTY_FULL_EMPTY_TEST_UVM 
`define FULL_EMPTY_FULL_EMPTY_TEST_UVM 

class full_empty_full_empty_test extends base_test;

	//factory registration 
	`uvm_component_utils(full_empty_full_empty_test)

	//constructor 
	function new(string name = "full_empty_full_empty_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//instance of sequences 
	write_seqs write_h;		//handle of write_seqs
	read_seqs read_h;		//handle of read_seqs 

	//run phase 
	//to check full and empty flag : full write and then full read 
	task run_phase (uvm_phase phase);
		phase.raise_objection(this);
		repeat(2) begin

			//write operation to fifo 
			write_h = write_seqs::type_id::create("write_h");
			assert(write_h.randomize() with {write_h.no_of_trans == 16;});
			write_h.start(env_h.agnt_h.seqr_h);

			//read operation from fifo 
			read_h = read_seqs::type_id::create("read_h");	
			assert(read_h.randomize() with {read_h.no_of_trans == 16;});
			read_h.start(env_h.agnt_h.seqr_h);
		end
			phase.phase_done.set_drain_time(this,40ns);
		phase.drop_objection(this);
	endtask

endclass

`endif 
