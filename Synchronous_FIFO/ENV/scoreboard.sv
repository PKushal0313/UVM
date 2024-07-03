`ifndef FIFO_SCOREBOARD_UVM
`define FIFO_SCOREBOARD_UVM 

//Macro to compare all the outputs
//`define MY_CUSTOM_INFO(DATA) \
//`uvm_info("TANISH", $sformatf("Data: %0d",DATA), UVM_MEDIUM)

`define compare_output(OP_REF,OP_MON) \
	if(OP_REF == OP_MON) \
		$display(`"Matched : reference model : %0d | monitor : %0d`",OP_REF,OP_MON); \
	else $display(`"MISMatched : reference model : %0d | monitor : %0d`",OP_REF,OP_MON); 

class scoreboard extends uvm_scoreboard;

	//factory registration 
	`uvm_component_utils(scoreboard)

	//analysis fifo 
	uvm_tlm_analysis_fifo #(seq_item) analysis_fifo_scr;

	//handle of seq_item 
	seq_item seq_item_h; 

	//constructor
	function new(string name = "scoreboard", uvm_component parent = null);
		super.new(name,parent);
		analysis_fifo_scr = new("analysis_fifo_scr",this);
	endfunction

	//signals for reference model 
	bit [7:0] array_q [$:15]; 	//queue array of size 16 : 0 to 15
	bit [`WIDTH-1:0] exp_rd_data; 	//expected read data 
	bit exp_full; 	//expected full flag 
	bit exp_empty; 	//expected empty flag 
	bit exp_half; 	//expected half flag 
	bit exp_overflow; 	//expected overflow flag
	bit exp_underflow; 	//expected underflow flag 

function void predictor(seq_item seq_item_h);
		$display("Predictor started at : %0t",$time);
		
		if(reset_flag == 1'b0) begin
			// write operation : writing into queue : through push_front method  
			$display("re flag : %0d : Recieved from if",reset_flag);
			if(seq_item_h.wr_enb == 1'b1 && !exp_full) begin
				array_q.push_front(seq_item_h.wr_data);
				$display("------------------------------ array_q after writing-------------------------------------------------------------");
		  	$info($sformatf("%2t | array_q : %0p",$time,array_q));
			end 

			// read opeartion : read from queue : through pop_back method 
			if(seq_item_h.rd_enb == 1'b1 && !exp_empty) begin
			 exp_rd_data = array_q.pop_back();
			 $display("exp_rd_data : %0d",exp_rd_data);
				$display("------------------------------ array_q after reading-------------------------------------------------------------");
		  	$info($sformatf("%2t | array_q : %0p",$time,array_q));
			end
		end
		else begin
			 exp_rd_data = 'd0;
			 array_q.delete();
			 $display("re flag : %0d : Recieved from else",reset_flag);
		end
		
		//------------------------------------------CHECK FLAGS---------------------------------------//
		if(array_q.size()==`DEPTH ) begin 
			exp_full = 1'b1;
		end 
		else begin 
			exp_full = 1'b0;
		end

		if(array_q.size()==0) begin
			exp_empty = 1'b1;
		end 
		else begin 
			exp_empty = 1'b0;
		end 
		
		if(array_q.size() == (`DEPTH/2)) begin
				exp_half = 1'b1;
		end 
		else begin 
				exp_half = 1'b0;
		end 
		 
		if((array_q.size() == `DEPTH) && (seq_item_h.wr_enb == 1)) begin
			exp_overflow = 1'b1;
		end 
		else begin 
			exp_overflow = 1'b0;
		end 

		if((array_q.size() == 0) && (seq_item_h.rd_enb == 1)) begin 
			exp_underflow = 1'b1;
		end 
		else begin
			exp_underflow = 1'b0;
		end 
		$display("size : %0d",array_q.size());	
		$display("Predictor completed at : %0t",$time);
 	endfunction 


	//build phase : To create component 
	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		seq_item_h = seq_item::type_id::create("seq_item_h");
	endfunction

	//Implementation of write method 
	virtual function void write(seq_item seq_item_h);
		`uvm_info("SCOREBOARD","Write Method",UVM_LOW)
		seq_item_h.print();
	endfunction

	task compare(seq_item seq_item_h);
			fork
				begin
					`uvm_info("CHECKER_RD_DATA"," --------------- RD_DATA_CHECK --------------",UVM_LOW)
					`compare_output(exp_rd_data,seq_item_h.rd_data);
					`uvm_info("CHECKER_FULL"," --------------- FULL_FLAG_CHECK --------------",UVM_LOW)
					`compare_output(exp_full,seq_item_h.full);
					`uvm_info("CHECKER_EMPTY"," --------------- EMPTY_FLAG_CHECK --------------",UVM_LOW)
					`compare_output(exp_empty,seq_item_h.empty);
					`uvm_info("CHECKER_HALF"," --------------- HALF_FLAG_CHECK --------------",UVM_LOW)
					`compare_output(exp_half,seq_item_h.half);
					`uvm_info("CHECKER_OVERFLOW"," --------------- OVERFLOW_FLAG_CHECK --------------",UVM_LOW)
					`compare_output(exp_overflow,seq_item_h.overflow);
					`uvm_info("CHECKER_UNDERFLOW"," --------------- UNDERFLOW_FLAG_CHECK --------------",UVM_LOW)
					`compare_output(exp_underflow,seq_item_h.underflow);
				end
				begin
					#30;
					`uvm_info("CHECKER_FAILED"," --------------- CHECKR_FAILED --------------",UVM_LOW)
					`uvm_info("CHECKER_FAILED"," --------------- TIMEOUT --------------",UVM_LOW)
				end 
			join_any
			disable fork;
	endtask

	//run phase 
	virtual task run_phase(uvm_phase phase);
		forever begin
			`uvm_info("SCOREBOARD_RUN",$sformatf("Run Phase of Scoreboard started at : %0t",$time),UVM_LOW)
			analysis_fifo_scr.get(seq_item_h);
			`uvm_info("SCOREBOARD","Packet Recieved at SCOREBOARD",UVM_LOW)
			seq_item_h.print();
			predictor(seq_item_h);
			compare(seq_item_h);
			`uvm_info("SCOREBOARD_RUN",$sformatf("Run Phase of Scoreboard completed at : %0t",$time),UVM_LOW)
		end 
	endtask
endclass

`endif 
