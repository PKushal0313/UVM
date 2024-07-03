`ifndef FIFO_READ_SEQS_UVM
`define FIFO_READ_SEQS_UVM 

class read_seqs extends base_sequence;

	//factory registration 
	`uvm_object_utils(read_seqs)

	//constructor 
	function new(string name = "read_seqs");
		super.new(name);
	endfunction

	task body();
		repeat(no_of_trans) begin
			`uvm_info("READ_SEQS",$sformatf("Body Method started for read_seqs at : %0t",$time),UVM_LOW)
			//starting the sequence for read 
			`uvm_create(seq_item_h)
			start_item(seq_item_h);
			assert(seq_item_h.randomize() with {rd_enb == 1;});
			finish_item(seq_item_h);
			`uvm_info("READ_SEQS",$sformatf("Body Method completed for read_seqs at: %0t",$time),UVM_LOW)
		end
	endtask

endclass

`endif 
