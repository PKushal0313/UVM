`ifndef FIFO_ENV_UVM
`define FIFO_ENV_UVM

class env extends uvm_env;

	//factory registration
	`uvm_component_utils(env)

	//constructor 
	function new(string name = "env",uvm_component parent = null);
		super.new(name,parent);
	endfunction

	//instance of agent and scoreboard 
	agent agnt_h; 	//handle of agent
	scoreboard scr_h; 	//handle of scoreboard 
	func_covg funcov_h; 	//handle of functional coverage class 

	//build phase 
	//To create components 
	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		agnt_h = agent::type_id::create("agnt_h",this);
		scr_h = scoreboard::type_id::create("scr_h",this);
		funcov_h = func_covg::type_id::create("funcov_h",this);
	endfunction

	//connect phase 
	//To connect the analysis port of monitor with analysis fifo of scoreboard 
	function void connect_phase (uvm_phase phase);
		super.connect_phase(phase);
		agnt_h.mon_h.mon_analysis_port.connect(scr_h.analysis_fifo_scr.analysis_export);
		agnt_h.mon_h.mon_analysis_port.connect(funcov_h.analysis_export);
	endfunction

endclass

`endif
