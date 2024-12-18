class apb_mcsequencer extends uvm_sequencer;

  	apb_sequencer apb_seqr;
	apb_slave_sequencer apb_slave_seqr;

	`uvm_component_utils_begin(apb_mcsequencer)
		`uvm_field_object(apb_seqr, UVM_ALL_ON)
		`uvm_field_object(apb_slave_seqr, UVM_ALL_ON)
	`uvm_component_utils_end
  	
	// constructor
  	function new(string name = "apb_mcsequencer" , uvm_component parent);
    	super.new(name, parent);
    	`uvm_info("Multichannel Sequencer Class","Inside Constructor", UVM_HIGH)
  
  	endfunction
  
endclass : apb_mcsequencer

