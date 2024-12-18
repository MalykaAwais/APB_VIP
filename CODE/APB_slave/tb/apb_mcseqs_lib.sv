class router_simple_mcseq extends uvm_sequence;
  
  	// Required macro for sequences automation
  	`uvm_object_utils(router_simple_mcseq)
	`uvm_declare_p_sequencer(router_mcsequencer)
	
	reset_seqs rst_seqs;
	simple_seqs ss_sqs;
	
	// Constructor
	function new(string name="router_simple_mcseq");
		super.new(name);
	endfunction

  task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask : pre_body
  

	virtual task body();
		`uvm_info(get_type_name(), "Executing router_simple_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_seqs, p_sequencer.wb_seqr)
        //`uvm_do_on(ss_sqs, p_sequencer.spi_seqr)
      	
  	endtask


  task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
  endtask : post_body

endclass
