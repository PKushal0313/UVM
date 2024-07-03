`ifndef FIFO_SEQ_ITEM_UVM
`define FIFO_SEQ_ITEM_UVM

class seq_item extends uvm_sequence_item;

	//declaration of write signals 
	rand bit wr_enb; //write enable 
	rand bit [`WIDTH-1:0] wr_data; //write data 

	//declaration of read signals 
	rand bit rd_enb; //read enable 
	bit [`WIDTH-1:0] rd_data; //read data

	//declaration of flags 
	bit full;
	bit empty;
	bit half;
	bit overflow;
	bit underflow;

	//utility and field macros 
	//in order to use the uvm_object methods
	`uvm_object_utils_begin(seq_item)
		`uvm_field_int(wr_enb,UVM_ALL_ON)
		`uvm_field_int(wr_data,UVM_ALL_ON | UVM_DEC)
		`uvm_field_int(rd_enb,UVM_ALL_ON)
		`uvm_field_int(rd_data,UVM_ALL_ON)
		`uvm_field_int(full,UVM_ALL_ON)
		`uvm_field_int(empty,UVM_ALL_ON)
		`uvm_field_int(half,UVM_ALL_ON)
		`uvm_field_int(overflow,UVM_ALL_ON)
		`uvm_field_int(underflow,UVM_ALL_ON)
	`uvm_object_utils_end

	//constructor
	function new (string name = "seq_item");
		super.new(name);
	endfunction

	//constraint to generate any one among wr_enb and rd_enb
	//defined as soft so we can override it whenever needed
	constraint wr_rd_enb {soft wr_enb != rd_enb;}

endclass

`endif 
