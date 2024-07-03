`ifndef FIFO_BACK_TO_BACK_WRITE_READ_TEST_UVM 
`define FIFO_BACK_TO_BACK_WRITE_READ_TEST_UVM

class back_to_back_write_read_test extends base_test;

	//factory registration
	`uvm_component_utils(back_to_back_write_read_test)

	//constructor 
	function new(string name = "back_to_back_write_read_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//instance of sequences 
	write_seqs write_h; 	//handle of write_seqs
	read_seqs read_h; 	//handle of read_seqs 

	//run phase 
	//to check back to back write read functionality 
	task run_phase (uvm_phase phase);
		phase.raise_objection(phase);
			repeat(10) begin 

				//write operation to fifo
				write_h = write_seqs::type_id::create("write_h");
				assert(write_h.randomize());
				write_h.start(env_h.agnt_h.seqr_h);

				//read operation from fifo 
				read_h = read_seqs::type_id::create("read_h");	
				assert(read_h.randomize());
				read_h.start(env_h.agnt_h.seqr_h);
			end 
		phase.drop_objection(phase);
	endtask 

endclass

`endif 
