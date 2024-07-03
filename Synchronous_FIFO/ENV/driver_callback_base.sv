`ifndef FIFO_DRIVER_CALLBACK_BASE_UVM
`define FIFO_DRIVER_CALLBACK_BASE_UVM 

virtual class driver_callback_base extends uvm_callback;

	//constructor 
	function new (string name = "driver_callback_use");
		super.new(name);
	endfunction
	
	//task for error injection 
	virtual task err_inj(ref seq_item seq_item_h);
	endtask 
	
endclass

`endif 
