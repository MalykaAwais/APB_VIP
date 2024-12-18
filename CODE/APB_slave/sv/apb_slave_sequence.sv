class apb_slave_base_seq extends uvm_sequence #(apb_slave_packet);
  
  // Required macro for sequences automation
  `uvm_object_utils(apb_slave_base_seq)

  // Constructor
  function new(string name="apb_slave_base_seq");
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
      `uvm_info(get_type_name(), "SLAVE SEQUENCE raise objection", UVM_MEDIUM)
    end
  endtask : pre_body

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

endclass : apb_slave_base_seq

class apb_no_delay_seq extends apb_slave_base_seq;
  
  `uvm_object_utils(apb_no_delay_seq)
  
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_no_delay_seq");
    super.new(name);
    `uvm_info("SLAVE_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
  
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
  task body();
   `uvm_info(get_type_name(), "Executing apb_no_delay_seq sequence**********************", UVM_LOW)
		`uvm_do_with(req,{delay== 0;})
		//`uvm_do_with(req,{delay== 0; pready ==0;})
  endtask: body
  
  
endclass: apb_no_delay_seq
  
class apb_delay_seq extends apb_slave_base_seq;

  `uvm_object_utils(apb_delay_seq)
  
  // It refers to the ACCESS Phase either read or write

  
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  
  function new(string name = "apb_delay_seq");
    super.new(name);
    `uvm_info("TEST_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
  
  //---------------------------
  //      TASK BODY
  //---------------------------
  
  virtual task body();
    `uvm_info(get_type_name(), "Executing apb_delay_seq sequence**********************", UVM_LOW)
 
      `uvm_do_with(req,{delay<= 5;})
      `uvm_do(req)
  endtask
    
endclass: apb_delay_seq
  
