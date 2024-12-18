`include "parameters.sv"
import param_pkg::*;
module tb_top;
	// import the UVM library
	import uvm_pkg::*;

	
	// include the UVM macros
	`include "uvm_macros.svh"
	
	// import the package
	import apb_pkg::*;
	import apb_slave_pkg::*;

      `include "apb_scoreboard.sv"
       `include "apb_module_env.sv"
	  `include "parameters.sv"
	`include "apb_mcsequencer.sv"
	`include "apb_mcseqs_lib.sv"
	`include "apb_tb.sv"
	`include "apb_test_lib.sv"
	
	
	
	initial
	begin
		apb_vif_config::set(null, "*.tb.master_uvc.*", "vif", hw_top.intf);
		apb_vif_config::set(null, "*.tb.slave_uvc.*", "vif", hw_top.intf);
		

  		run_test();
    	
	end
	
	
endmodule 
