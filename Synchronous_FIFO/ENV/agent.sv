`ifndef FIFO_AGENT_UVM
`define FIFO_AGENT_UVM

class agent extends uvm_agent;

	//factory registration
	`uvm_component_utils(agent)

	//constructor
	function new (string name = "agent", uvm_component parent = null);
		super.new(name,parent);
	endfunction 

	//handle of virtual interface 
	virtual intf vintf;

	//declaring agent components
	driver drv_h; 	//handle of driver 
	sequencer seqr_h; 	//hanle of sequencer
	monitor mon_h; 		//handle of monitor 

	//build phase 
	//To get the virtual interface 
	//create all the components of agent
	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(virtual intf)::get(this,"","vintf",vintf))
			`uvm_fatal("AGENT","Virtual interface is not available in AGENT")
		drv_h = driver::type_id::create("drv_h",this);
		seqr_h = sequencer::type_id::create("seqr_h",this);
		mon_h = monitor::type_id::create("mon_h",this);
	endfunction 

	//connect phase 
	//To connect the driver port to the sequencer export 
	function void connect_phase (uvm_phase phase);
		super.connect_phase(phase);
		drv_h.seq_item_port.connect(seqr_h.seq_item_export);
	endfunction

endclass

`endif
