`ifndef FIFO_SIMUL_WRITE_READ_TEST_UVM
`define FIFO_SIMUL_WRITE_READ_TEST_UVM 

class simul_write_read_test extends base_test;

	//factory registration 
	`uvm_component_utils(simul_write_read_test)

	//constructor 
	function new (string name = "simul_write_read_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//instance of sequences 
	write_seqs write_h; 	//handle of write_seqs
	simul_write_read_seqs simul_wr_h; 	//handle of simul_write_read_seqs 

	//run phase 
	//Firstly will write data into fifo using write_seqs 
	//Then do simultaneous write read using the simul_write_read_seqs 
	task run_phase (uvm_phase phase);
		phase.raise_objection(this);
	
			//Write operation to FIFO
			write_h = write_seqs::type_id::create("write_h");
			assert(write_h.randomize() with {write_h.no_of_trans == 5;});
			write_h.start(env_h.agnt_h.seqr_h);

			//Simultaneous write read operation to FIFO 
			simul_wr_h = simul_write_read_seqs::type_id::create("simul_wr_h");	
			assert(simul_wr_h.randomize() with {simul_wr_h.no_of_trans == 8;});
			simul_wr_h.start(env_h.agnt_h.seqr_h);

			phase.phase_done.set_drain_time(this,40ns);
		phase.drop_objection(this);
	endtask

endclass

`endif 
