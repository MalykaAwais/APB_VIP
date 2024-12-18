class apb_tb extends uvm_env;
	
  	apb_env master_uvc;
	//wishbone_env wb_uvc;
	//router_mcsequencer mc_seqr;

	`uvm_component_utils_begin(apb_tb)
		`uvm_field_object(master_uvc, UVM_ALL_ON)
		//`uvm_field_object(wb_uvc, UVM_ALL_ON)
		//`uvm_field_object(mc_seqr, UVM_ALL_ON)
	`uvm_component_utils_end
  	
	// constructor
  	function new(string name = "apb_tb" , uvm_component parent);
    	super.new(name, parent);
    	`uvm_info("Testbench_class","Inside Constructor", UVM_HIGH)
    
  	endfunction
  
	//build phase
  	function void build_phase(uvm_phase phase);  //obj handle of uvm_phase
    	super.build_phase(phase);

    	master_uvc = apb_env::type_id::create("master_uvc", this);
		//wb_uvc = wishbone_env::type_id::create("wb_uvc", this);
		
		//mc_seqr = router_mcsequencer::type_id::create("mc_seqr", this);
		
    	`uvm_info("apb_tb","Build phase", UVM_HIGH)      

  	endfunction
  	
  	function void connect_phase(uvm_phase phase);
  		`uvm_info(get_type_name(), "Connecting the Sequencer and the ports...", UVM_HIGH);
  		
  		//mc_seqr.wb_seqr = wb_uvc.agent.sequencer;
  		//mc_seqr.spi_seqr = spi_uvc.agent.sequencer;
  		
  		`uvm_info(get_type_name(), "Connection Complete", UVM_HIGH);
	endfunction
  	
	function void start_of_simulation_phase(uvm_phase phase);
  		`uvm_info(get_type_name(), "Running Simulation...", UVM_HIGH);
	endfunction
  
endclass : apb_tb
