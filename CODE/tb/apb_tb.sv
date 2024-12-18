class apb_tb extends uvm_env;
	
  	apb_env master_uvc;
	apb_slave_env slave_uvc;
	apb_mcsequencer mc_seqr;
    apb_module_env apb_module_env_handle;
	
	`uvm_component_utils_begin(apb_tb)
		`uvm_field_object(master_uvc, UVM_ALL_ON)
		`uvm_field_object(slave_uvc, UVM_ALL_ON)
		`uvm_field_object(mc_seqr, UVM_ALL_ON)
		//`uvm_field_object(router_module_env_handle, UVM_ALL_ON)
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
		slave_uvc = apb_slave_env::type_id::create("slave_uvc", this);
		
		mc_seqr = apb_mcsequencer::type_id::create("mc_seqr", this);
		apb_module_env_handle = apb_module_env::type_id::create("apb_module_env_handle", this);
    	`uvm_info("apb_tb","Build phase", UVM_HIGH)      

  	endfunction
  	
  	function void connect_phase(uvm_phase phase);
  		`uvm_info(get_type_name(), "Connecting the Sequencer and the ports...", UVM_HIGH);
  		
  		mc_seqr.apb_seqr = master_uvc.agent.sequencer;
  		mc_seqr.apb_slave_seqr = slave_uvc.agent.sequencer;	       		 master_uvc.agent.monitor.master_out.connect(apb_module_env_handle.master_export_port);
		slave_uvc.agent.monitor.slave_out.connect(apb_module_env_handle.slave_export_port);
  		`uvm_info(get_type_name(), "Connection Complete", UVM_HIGH);
	endfunction
  	
	function void start_of_simulation_phase(uvm_phase phase);
  		`uvm_info(get_type_name(), "Running Simulation...", UVM_HIGH);
	endfunction
  
endclass : apb_tb
