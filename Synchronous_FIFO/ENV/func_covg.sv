`ifndef FIFO_FUNCTIONAL_COVERAGE_UVM
`define FIFO_FUNCITONAL_COVERAGE_UVM

//It encapsulates the uvm_analysis_export and associated virtual write method 
//analysis export for recieving transactions from a connected analysis export 
class func_covg extends uvm_subscriber #(seq_item);
	
	//factory registration 
	`uvm_component_utils(func_covg)

	//handle of sew_item 
	seq_item seq_item_h;

	//covergroup 
	covergroup cvg_grp;
		
		//coverpoint for write enable : Transition 
		coverpoint_wr_enb : coverpoint seq_item_h.wr_enb 
		{
			option.comment = "Coverpoint for write enable which will check transition of from 0 to 1 and 1 to 0";
			bins wr_toggle_0to1 = (0 => 1);
			bins wr_toggle_1to0 = (1 => 0);
		}

		//coveroint for read enable : Transition  
		coverpoint_rd_enb : coverpoint seq_item_h.rd_enb 
		{
			option.comment = "Coverpoint for read enable which will check transition of from 0 to 1 and 1 to 0";
			bins rd_toggle_0to1 = (0 => 1);
			bins rd_toggle_1to0 = (1 => 0);
		}
		
		//coverpoint for write data : in ranges : Low range, Mid range and High range  
		coverpoint_wr_data : coverpoint seq_item_h.wr_data 
		{
			option.comment = "Coverpoint for write data which will devide data in 3 ranges";		
			bins range[3] = {[1:$]};
		}
		
		//coverpoint for read data : in ranges : Low range, Mid range and High range 
		coverpoint_rd_data : coverpoint seq_item_h.rd_data 
		{
			option.comment = "Coverpoint for read data which will devide data in 3 ranges";		
			bins range[3] = {[1:$]};
		}

		//coverpoint full : Transition bin 
		coverpoint_full : coverpoint seq_item_h.full 
		{
			option.comment = "Coverpoint for full flag which will check transition of from 0 to 1 and 1 to 0";
			bins full_toggle[] = (0 => 1, 1 => 0);
		}
		
		//coverpoint empty : Transition bin 
		coverpoint_empty : coverpoint seq_item_h.empty 
		{	
			option.comment = "Coverpoint for empty flag which will check transition of from 0 to 1 and 1 to 0";
			bins empty_toggle[] = (0 => 1, 1 => 0);
		}
		//coverpoint half : Transition bin 
		coverpoint_half : coverpoint seq_item_h.half 
		{
			option.comment = "Coverpoint for half flag which will check transition of from 0 to 1 and 1 to 0";
			bins half_toggle[] = (0 => 1, 1 => 0);
		}
		
		//coverpoint overflow : Transition bin 
		coverpoint_overflow : coverpoint seq_item_h.overflow 
		{
			option.comment = "Coverpoint for overflow flag which will check transition of from 0 to 1 and 1 to 0";
			bins overflow_toggle[] = (0 => 1, 1 => 0);
		}
		
		//coverpoint underflow : Trasition bin 	
		coverpoint_underflow : coverpoint seq_item_h.underflow
		{	
			option.comment = "Coverpoint for underflow flag which will check transition of from 0 to 1 and 1 to 0";
			bins underflow_toggle[] = (0 => 1, 1 => 0);
		}
	
		//coverpoint for reset 
		coverpoint_reset_check : coverpoint seq_item_h.rd_data iff(reset_flag == 1)
		{	
			option.comment = "Coverpoint to check the reset using wildcard bins";
			wildcard bins rst_bin = (8'b????_???? => 8'b0000_0000);
		}
		
		//coverpoint for back to back write read, back to back write(multiple write) and back to back read(multiple read)
		coverpoint_back2back : coverpoint {seq_item_h.wr_enb,seq_item_h.rd_enb} 
		{
			option.comment = "Coverpoint to check back to back write read, back to back write and back to back read";
			bins bck2bck_wr = (2'b10 => 2'b01);
			bins bck2bck_w = (2'b10 => 2'b10);
			bins bck2bck_r = (2'b01 => 2'b01);
		}
	
	endgroup
	
	//constructor 
	function new(string name = "func_covg",uvm_component parent = null);
		super.new(name,parent);
		seq_item_h = seq_item::type_id::create("seq_item_h"); 	//creating handle of seq_item
		cvg_grp = new(); 	//creating covergroup 
	endfunction

	//write method which is encapsulted in uvm_subscriber 
	virtual function void write(input seq_item t);
		`uvm_info("FUNC_COVG","Packet Recieved at Function coverage",UVM_LOW)
		t.print();
		seq_item_h = t;
		cvg_grp.sample();
	endfunction

endclass

`endif 
