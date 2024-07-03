`ifndef FIFO_WRITE_SEQS_UVM 
`define FIFO_WRITE_SEQS_UVM

class write_seqs extends base_sequence;

	//factory registration 
	`uvm_object_utils(write_seqs)

	//constructor 
	function new(string name = "write_seqs");
		super.new(name);
	endfunction

	task body();
		repeat(no_of_trans) begin
			`uvm_info("WRITE_SEQS",$sformatf("Body Method started for write_seqs at : %0t",$time),UVM_LOW)
			//stating the sequence for write 
			`uvm_create(seq_item_h) 	
			start_item(seq_item_h); 
			assert(seq_item_h.randomize() with {wr_enb == 1;});
			finish_item(seq_item_h);
			`uvm_info("WRITE_SEQS",$sformatf("Body Method completed for write_seqs at: %0t",$time),UVM_LOW)
		end
	endtask

endclass 

`endif 
