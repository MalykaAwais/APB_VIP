class base_test extends uvm_test;
	`uvm_component_utils(base_test)
	apb_tb tb;
  	
	//constructor
	function new(string name = "base_test" , uvm_component parent);
    	super.new(name, parent);
    	`uvm_info("Test Class","Inside Constructor", UVM_HIGH)
  	endfunction
  		
  	//build phase
  	virtual function void build_phase(uvm_phase phase);  
    	super.build_phase(phase);
    	`uvm_info("Test Class","Build phase", UVM_HIGH)
    	 tb = apb_tb::type_id::create("tb",this);
  	 uvm_config_int::set( this, "*", "recording_detail", 1);
  	 uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_write_then_read_on_same_address_mcseq::get_type());
  	endfunction 
  	
  	task run_phase(uvm_phase phase);
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


//==================
//  apb_simple_mcseq_test
//==================

class apb_simple_mcseq_test extends base_test;

  `uvm_component_utils(apb_simple_mcseq_test)

  function new(string name = "apb_simple_mcseq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slave
    uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_simple_mcseq::get_type());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass : apb_simple_mcseq_test

//==================
// apb_single_write_mcseq_test
//==================

class apb_single_write_mcseq_test extends base_test;

  `uvm_component_utils(apb_single_write_mcseq_test)

  function new(string name = "apb_single_write_mcseq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slave
    uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_single_write_mcseq::get_type());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass : apb_single_write_mcseq_test

//==================
// apb_single_read_mcseq_test
//==================

class apb_single_read_mcseq_test extends base_test;

  `uvm_component_utils(apb_single_read_mcseq_test)

  function new(string name = "apb_single_read_mcseq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slave
    uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_single_read_mcseq::get_type());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass : apb_single_read_mcseq_test

//==================
// apb_single_read_mcseq_test
//==================

class apb_read_after_write_mcseq_test extends base_test;

  `uvm_component_utils(apb_read_after_write_mcseq_test)

  function new(string name = "apb_read_after_write_mcseq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slave
    uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_read_after_write_mcseq::get_type());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass : apb_read_after_write_mcseq_test

//==================
// apb_single_read_mcseq_test
//==================

class apb_BULK_read_after_write_mcseq_test extends base_test;

  `uvm_component_utils(apb_BULK_read_after_write_mcseq_test)

  function new(string name = "apb_BULK_read_after_write_mcseq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slave
    uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_BULK_read_after_write_mcseq::get_type());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass : apb_BULK_read_after_write_mcseq_test


//==================
// apb_single_read_mcseq_test
//==================

class apb_backToBackWrite_mcseq_test extends base_test;

  `uvm_component_utils(apb_backToBackWrite_mcseq_test)

  function new(string name = "apb_backToBackWrite_mcseq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slave
    uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_backToBackWrite_mcseq::get_type());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass : apb_backToBackWrite_mcseq_test

//==================
// apb_single_read_mcseq_test
//==================

class apb_backToBackRead_mcseq_test extends base_test;

  `uvm_component_utils(apb_backToBackRead_mcseq_test)

  function new(string name = "apb_backToBackRead_mcseq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slave
    uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_backToBackRead_mcseq::get_type());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass : apb_backToBackRead_mcseq_test

//==================
// apb_slaveDeassertSeq_mcseq_test
//==================

class apb_slaveDeassertSeq_mcseq_test extends base_test; 

  `uvm_component_utils(apb_slaveDeassertSeq_mcseq_test)

  function new(string name = "apb_slaveDeassertSeq_mcseq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slave
    uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_slaveDeassertSeq_mcseq::get_type());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass : apb_slaveDeassertSeq_mcseq_test

//==================
// apb_Randomized_no_of_transaction_mcseq_test
//==================

class apb_Randomized_no_of_transaction_mcseq_test extends base_test; 

  `uvm_component_utils(apb_Randomized_no_of_transaction_mcseq_test)

  function new(string name = "apb_Randomized_no_of_transaction_mcseq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slave
    uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_Randomized_no_of_transaction_mcseq::get_type());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass : apb_Randomized_no_of_transaction_mcseq_test

//==================
// apb_Random_Write_Read_Interleaved_mcseq_test
//==================

class apb_Random_Write_Read_Interleaved_mcseq_test extends base_test; 

  `uvm_component_utils(apb_Random_Write_Read_Interleaved_mcseq_test)

  function new(string name = "apb_Random_Write_Read_Interleaved_mcseq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slave
    uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_Random_Write_Read_Interleaved_mcseq::get_type());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass : apb_Random_Write_Read_Interleaved_mcseq_test

//==================
// apb_single_write_with_delayed_pready_mcseq_test
//==================

class apb_single_write_with_delayed_pready_mcseq_test extends base_test; 

  `uvm_component_utils(apb_single_write_with_delayed_pready_mcseq_test)

  function new(string name = "apb_single_write_with_delayed_pready_mcseq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slave
    uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_single_write_with_delayed_pready_mcseq::get_type());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass :apb_single_write_with_delayed_pready_mcseq_test

//==================
// apb_single_read_with_delayed_pready_mcseq_test
//==================

class apb_single_read_with_delayed_pready_mcseq_test extends base_test; 

  `uvm_component_utils(apb_single_read_with_delayed_pready_mcseq_test)

  function new(string name = "apb_single_read_with_delayed_pready_mcseq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slave
    uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_single_read_with_delayed_pready_mcseq::get_type());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass :apb_single_read_with_delayed_pready_mcseq_test

//==================
// apb_read_after_write_with_delayed_pready_mcseq_test
//==================

class apb_read_after_write_with_delayed_pready_mcseq_test extends base_test; 

  `uvm_component_utils(apb_read_after_write_with_delayed_pready_mcseq_test)

  function new(string name = "apb_read_after_write_with_delayed_pready_mcseq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slave
    uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_read_after_write_with_delayed_pready_mcseq::get_type());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass :apb_read_after_write_with_delayed_pready_mcseq_test

//==================
// apb_BULK_read_after_write_with_delayed_pready_mcseq_test
//==================

class apb_BULK_read_after_write_with_delayed_pready_mcseq_test extends base_test; 

  `uvm_component_utils(apb_BULK_read_after_write_with_delayed_pready_mcseq_test)

  function new(string name = "apb_BULK_read_after_write_with_delayed_pready_mcseq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slave
    uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_BULK_read_after_write_with_delayed_pready_mcseq::get_type());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass :apb_BULK_read_after_write_with_delayed_pready_mcseq_test

//==================
// apb_backToBackWrite_with_delayed_pready_mcseq_test
//==================

class apb_backToBackWrite_with_delayed_pready_mcseq_test extends base_test; 

  `uvm_component_utils(apb_backToBackWrite_with_delayed_pready_mcseq_test)

  function new(string name = "apb_backToBackWrite_with_delayed_pready_mcseq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slave
    uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_backToBackWrite_with_delayed_pready_mcseq::get_type());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass :apb_backToBackWrite_with_delayed_pready_mcseq_test

//==================
// apb_backToBackRead_with_delayed_pready_mcseq_test
//==================

class apb_backToBackRead_with_delayed_pready_mcseq_test extends base_test; 

  `uvm_component_utils(apb_backToBackRead_with_delayed_pready_mcseq_test)

  function new(string name = "apb_backToBackRead_with_delayed_pready_mcseq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slave
    uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_backToBackRead_with_delayed_pready_mcseq::get_type());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass :apb_backToBackRead_with_delayed_pready_mcseq_test

//==================
// apb_Randomized_no_of_transaction_with_delayed_pready_mcseq_test
//==================

class apb_Randomized_no_of_transaction_with_delayed_pready_mcseq_test extends base_test; 

  `uvm_component_utils(apb_Randomized_no_of_transaction_with_delayed_pready_mcseq_test)

  function new(string name = "apb_Randomized_no_of_transaction_with_delayed_pready_mcseq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slave
    uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_Randomized_no_of_transaction_with_delayed_pready_mcseq::get_type());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass :apb_Randomized_no_of_transaction_with_delayed_pready_mcseq_test

//==================
// apb_Random_Write_Read_Interleaved_with_delayed_pready_mcseq_test
//==================

class apb_Random_Write_Read_Interleaved_with_delayed_pready_mcseq_test extends base_test; 

  `uvm_component_utils(apb_Random_Write_Read_Interleaved_with_delayed_pready_mcseq_test)

  function new(string name = "apb_Random_Write_Read_Interleaved_with_delayed_pready_mcseq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slave
    uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_Random_Write_Read_Interleaved_with_delayed_pready_mcseq::get_type());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass :apb_Random_Write_Read_Interleaved_with_delayed_pready_mcseq_test

//==================
// apb_BULK_read_after_write_with_no_delay_and_delayed_pready_mcseq_test
//==================

class apb_BULK_read_after_write_with_no_delay_and_delayed_pready_mcseq_test extends base_test; 

  `uvm_component_utils(apb_BULK_read_after_write_with_no_delay_and_delayed_pready_mcseq_test)

  function new(string name = "apb_BULK_read_after_write_with_no_delay_and_delayed_pready_mcseq_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    // Set the default sequence for the master and slave
    uvm_config_wrapper::set(this, "tb.mc_seqr.run_phase","default_sequence", apb_BULK_read_after_write_with_no_delay_and_delayed_pready_mcseq::get_type());
    // Create the tb
    super.build_phase(phase);
  endfunction : build_phase

endclass :apb_BULK_read_after_write_with_no_delay_and_delayed_pready_mcseq_test
