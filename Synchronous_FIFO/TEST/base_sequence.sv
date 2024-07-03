`ifndef FIFO_BASE_SEQUENCE_UVM
`define FIFO_BASE_SEQUENCE_UVM

class base_sequence extends uvm_sequence #(seq_item);
	
	//factory registration
	`uvm_object_utils(base_sequence)

	//handle of sequence item 
	seq_item seq_item_h;

	//for providing number of transfers 
	rand int no_of_trans;

	//default constraint for number of transaction
	constraint no_trans {soft no_of_trans == 1;}

	//constructor 
	function new (string name = "base_sequence");
		super.new(name);
	endfunction

endclass

`endif 
