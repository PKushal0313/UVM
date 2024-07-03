`ifndef FIFO_DRIVER_CALLBACK_USER_UVM
`define FIFO_DRIVER_CALLBACK_USER_UVM

class driver_callback_user extends driver_callback_base;

	//constructor 
	function new (string name = "driver_callback_user");
		super.new(name);
	endfunction

	//virtual interface 
	virtual intf vintf;

	//error injection class 
	//firstly get the interface through config_db 
	task err_inj(ref seq_item seq_item_h);
		if(!uvm_config_db#(virtual intf)::get(null,"","vintf",vintf))
			`uvm_fatal("DRIVER_CALLBACK_USER","Virtual interface is not available in DRIVER_CALLBACK_USER")

		//driving the signals to DUT through virtual interface without any condition 
		//for overflow and underflow flag check 
		vintf.drv_cb.wr_enb <= seq_item_h.wr_enb;
		vintf.drv_cb.wr_data <= seq_item_h.wr_data;
		vintf.drv_cb.rd_enb <= seq_item_h.rd_enb;
		
		`uvm_info("DRIVER_USER_CALLBACK","Packet Printing from DRIVER_USER_CALLBACK",UVM_LOW)
		seq_item_h.print();
		`uvm_info("DRIVER_CALLBACK_USER","Driving to DUT from driver_callback_user",UVM_LOW)
	endtask

endclass 

`endif 
