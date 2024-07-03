`ifndef FIFO_DRV_UVM
`define FIFO_DRV_UVM

class driver extends uvm_driver #(seq_item);

	//factory registration
	`uvm_component_utils(driver)

	//callback registration 
	`uvm_register_cb(driver,driver_callback_base)

	//constructor
	function new (string name = "driver", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//handle of virtual interface 
	virtual intf vintf;

	//get interface handle using get config_db
	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(virtual intf)::get(this,"","vintf",vintf))
			`uvm_fatal("DRIVER","Virtual interface is not available in DRIVER")
	endfunction

	//run_phase 
	virtual task run_phase (uvm_phase phase);
	wait(!vintf.rstn) //TODO : We can also use if 
		initialization();
	wait(vintf.rstn);
		forever begin
		//	`uvm_info("DRIVER_RUN",$sformatf("Run Phase of Driver started at : %0t",$time),UVM_LOW)
			seq_item_port.get_next_item(req); 
			fork
				//Process-1 : initialization 
				begin
					wait(!vintf.rstn)
						initialization();
				end

				//Process-2 : Drive to DUT 
				begin
				//	wait(vintf.rstn)
						drive_to_dut(req);
				end
			join_any
			disable fork;
			wait(vintf.rstn);
			seq_item_port.item_done();
	//		`uvm_info("DRIVER_RUN",$sformatf("Run Phase of Driver completed at : %0t",$time),UVM_LOW)
		end
	endtask

	//initialization task
	//Whenever Reset is active all the inputs will get initial values
	task initialization();
	//	`uvm_info("DRIVER_INIT",$sformatf("Reset Started at : %0t",$time),UVM_LOW)
		vintf.drv_cb.wr_enb <= 1'b0;
		vintf.drv_cb.rd_enb <= 1'b0;
		vintf.drv_cb.wr_data <= 'd0;
		wait(vintf.rstn);
	//	`uvm_info("DRIVER_INIT",$sformatf("Reset Completed at : %0t",$time),UVM_LOW)
	endtask

	//drive to dut task
	//To drive the input signals to DUT through interface 
	task drive_to_dut(seq_item seq_item_h);
	//	seq_item_h.print();
		@(vintf.drv_cb);
	//	`uvm_info("DRIVER_DTOD",$sformatf("Started Driving to DUT at : %0t",$time),UVM_LOW)
		if(!vintf.drv_cb.full) begin
			vintf.drv_cb.wr_enb <= seq_item_h.wr_enb;
			vintf.drv_cb.wr_data <= seq_item_h.wr_data;
		end
		if(!vintf.drv_cb.empty) begin
			vintf.drv_cb.rd_enb <= seq_item_h.rd_enb;
		end

		//callback method : to drive the value of wr_enb,rd_enb and wr_data without checking the condition
		//specifically for overflow and underflow condition 
		`uvm_do_callbacks(driver,driver_callback_base,err_inj(seq_item_h))

		`uvm_info("DRIVER_DTOD",$sformatf("Packet sent from Driver"),UVM_LOW)
		seq_item_h.print();
	//	`uvm_info("DRIVER_DTOD",$sformatf("Completed Driving to DUT at : %0t",$time),UVM_LOW)
	endtask


endclass

`endif
