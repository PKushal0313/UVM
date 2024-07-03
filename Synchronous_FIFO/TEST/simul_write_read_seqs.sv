`ifndef FIFO_SIMUL_WRITE_READ_SEQS_UVM
`define FIFO_SIMUL_WRITE_READ_SEQS_UVM

class simul_write_read_seqs extends base_sequence;

	//factory registration
	`uvm_object_utils(simul_write_read_seqs)

	//constructor 
	function new (string name = "simul_write_read_seqs");
		super.new(name);
	endfunction

	//body method : simultaneous write read  
	task body();
		repeat(no_of_trans) begin
			`uvm_info("SIMUL_WRITE_READ_SEQS",$sformatf("Body Method started for simul_write_read_seqs at : %0t",$time),UVM_LOW)
			`uvm_create(seq_item_h) 	//creating handle of seq_item_h
			start_item(seq_item_h); 
			assert(seq_item_h.randomize() with {wr_enb == 1; rd_enb == 1;});
			finish_item(seq_item_h);
			`uvm_info("SIMUL_WRITE_READ_SEQS",$sformatf("Body Method completed for simul_write_read_seqs at: %0t",$time),UVM_LOW)
		end
	endtask

endclass

`endif
