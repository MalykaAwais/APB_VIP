`include "parameters.sv"
import param_pkg::*;
module tb_top;
	// import the UVM library
	import uvm_pkg::*;

	
	// include the UVM macros
	`include "uvm_macros.svh"
	
	// import the YAPP package
	import apb_pkg::*;
        `include "parameters.sv"
	//import wishbone_pkg::*;
	
	//`include "apb_mcsequencer.sv"
	//`include "apb_mcseqs_lib.sv"
	`include "apb_tb.sv"
	`include "apb_test_lib.sv"
	//`include "../sv/apb_scoreboard.sv"
	
	
	// generate 5 random packets and use the print method
	initial
	begin
		apb_vif_config::set(null, "*.tb.master_uvc.*", "vif", hw_top.intf);
		//wishbone_vif_config::set(null, "*.tb.wb_uvc.*", "vif", hw_top.wb_intf);

  		run_test();
    	
	end
	
	
endmodule : top
