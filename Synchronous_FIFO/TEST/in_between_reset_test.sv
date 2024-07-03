`ifndef FIFO_IN_BETWEEN_RESET_TEST_UVM
`define FIFO_IN_BETWEEN_RESET_TEST_UVM 

class in_between_reset_test extends base_test;

	//factory registration
	`uvm_component_utils(in_between_reset_test)

	//constructor 
	function new(string name = "in_between_reset_test",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//instance of sequences 
	write_seqs write_h; 	//handle of write sequence 
	read_seqs read_h;		//handle of read sequence 
	
	//run phase 
	//will write data to fifo 
	//read data from fifo 
	task run_phase (uvm_phase phase);
		phase.raise_objection(this);
		repeat(2) begin

			//write operation to fifo 
			write_h = write_seqs::type_id::create("write_h");
			assert(write_h.randomize() with {write_h.no_of_trans == 6;});
			write_h.start(env_h.agnt_h.seqr_h);

			//read operation from fifo 
			read_h = read_seqs::type_id::create("read_h");	
			assert(read_h.randomize() with {read_h.no_of_trans == 4;});
			read_h.start(env_h.agnt_h.seqr_h);

			//event trigger for reset
			-> reset_ev;

		end
			phase.phase_done.set_drain_time(this,40ns);
		phase.drop_objection(this);
	endtask

endclass

`endif
