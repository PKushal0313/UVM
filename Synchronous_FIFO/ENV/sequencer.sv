`ifndef FIFO_SEQUENCER_UVM
`define FIFO_SEQUENCER_UVM

class sequencer extends uvm_sequencer #(seq_item);

	//factory registration
	`uvm_component_utils(sequencer)

	//constructor 
	function new (string name = "sequencer", uvm_component parent = null);
		super.new(name,parent);
	endfunction

endclass

`endif
