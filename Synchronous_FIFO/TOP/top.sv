`ifndef FIFO_TOP_UVM 
`define FIFO_TOP_UVM

`include "interface.sv"
`include "package.sv"
`include "../RTL/design.v"
import pkg::*;
import uvm_pkg::*;

module top;

	//clock and reset : global signals 
	bit clk = 1'b0;
  bit rstn;

	//instance of interface
	intf int_f(clk,rstn);

	//DUT instance 
	synchronous_fifo DUT (.clk(clk),
						.rstn(int_f.rstn),
						.wr_enb(int_f.wr_enb),
						.wr_data(int_f.wr_data),
						.rd_enb(int_f.rd_enb),
						.rd_data(int_f.rd_data),
						.full(int_f.full),
						.empty(int_f.empty),
						.half(int_f.half),
						.overflow(int_f.overflow),
						.underflow(int_f.underflow)
						); 

	//clock generation
	initial begin 
		forever #5 clk = ~clk;
	end 

	task reset_done();
		fork 
			forever@(reset_ev) begin 
				reset();
			end 
		join_none 
	endtask 

	
	//reset generation 
	task reset();
		rstn = 1'b0;
		reset_flag = 1'b1;
		#DELAY;
		rstn = 1'b1;
		reset_flag = 1'b0;
	endtask

	initial begin
		uvm_config_db #(virtual intf)::set(null,"*","vintf",int_f);
		
		fork
			reset_done();
			->reset_ev;
			run_test();
		join

	end 

	
endmodule 

`endif 

