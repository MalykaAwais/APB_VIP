class base_test extends uvm_test;
	`uvm_component_utils(base_test)
	apb_tb tb;
  	
	//constructor
	function new(string name = "base_test" , uvm_component parent);
    	super.new(name, parent);
    	`uvm_info("Test Class","Inside Constructor", UVM_HIGH)
  	endfunction
  		
  	//build phase
  	virtual function void build_phase(uvm_phase phase);  //obj handle of uvm_phase
    	super.build_phase(phase);
    	`uvm_info("Test Class","Build phase", UVM_HIGH)
    	
    	//uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", router_simple_mcseq::get_type());
    	uvm_config_wrapper::set(this, "tb.master_uvc.agent.sequencer.run_phase","default_sequence", apb_exhaustive_seq::get_type());
    	
    	tb = apb_tb::type_id::create("tb",this);
  		
  		uvm_config_int::set( this, "*", "recording_detail", 1);
  		
  	endfunction 
  	task run_phase(uvm_phase phase);
  		//super.run_phase(phase);
  		uvm_objection obj = phase.get_objection();
  		obj.set_drain_time(this, 40ns);
  	endtask
 	//end_of_elaboration_phase
  	function void end_of_elaboration_phase(uvm_phase phase);
  		super.end_of_elaboration_phase(phase);
    	uvm_top.print_topology();
  	
  	endfunction
  	
  	function void check_phase(uvm_phase phase);
  		check_config_usage();
  	endfunction
  	
endclass : base_test





