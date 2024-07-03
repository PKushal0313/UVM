`ifndef FIFO_MONITOR_UVM
`define FIFO_MONITOR_UVM

class monitor extends uvm_monitor;

	//factory registration 
	`uvm_component_utils(monitor)

	//handle of virtual interface 
	virtual intf vintf;

	//declaration of analysis port 
	uvm_analysis_port #(seq_item) mon_analysis_port;

	//handle of seq_item to sample the signal activity 
	seq_item seq_item_h;

	//constructor
	function new(string name="monitor", uvm_component parent = null);
		super.new(name,parent);
		mon_analysis_port = new("mon_analysis_port",this);
	endfunction
	
	//build phase method 
	//Get interface handle using get config_db 
	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(virtual intf)::get(this,"","vintf",vintf))
			`uvm_fatal("MONITOR","Virtual interface is not available in MONITOR")
		seq_item_h = seq_item::type_id::create("seq_item_h");
	endfunction

	//run phase 
	virtual task run_phase(uvm_phase phase);
		forever begin
	//		`uvm_info("MONITOR_RUN",$sformatf("Run Phase of Monitor started at : %0t",$time),UVM_LOW)
			@(vintf.mon_cb) begin
				if(vintf.mon_cb.wr_enb) begin
					seq_item_h.wr_enb = vintf.mon_cb.wr_enb;
					seq_item_h.rd_enb = vintf.mon_cb.rd_enb;
					seq_item_h.wr_data = vintf.mon_cb.wr_data;
					seq_item_h.full = vintf.mon_cb.full;
					seq_item_h.empty = vintf.mon_cb.empty;
					seq_item_h.half = vintf.mon_cb.half;
					seq_item_h.overflow = vintf.mon_cb.overflow;
					seq_item_h.underflow = vintf.mon_cb.underflow;
				end
				if(vintf.mon_cb.rd_enb) begin
					seq_item_h.rd_enb = vintf.mon_cb.rd_enb;
					seq_item_h.wr_enb = vintf.mon_cb.wr_enb;
					seq_item_h.rd_data = vintf.mon_cb.rd_data;
					seq_item_h.full = vintf.mon_cb.full;
					seq_item_h.empty = vintf.mon_cb.empty;
					seq_item_h.half = vintf.mon_cb.half;
					seq_item_h.overflow = vintf.mon_cb.overflow;
					seq_item_h.underflow = vintf.mon_cb.underflow;
				end
				`uvm_info("MONITOR_RUN","Packet recieved at Monitor",UVM_LOW)
				seq_item_h.print();
				//Sending sampled transaction packet to scoreboard
				mon_analysis_port.write(seq_item_h);
			end 
		end
	endtask

endclass

`endif 
