class apb_sequencer extends uvm_sequencer #(apb_packet);

  `uvm_component_utils(apb_sequencer)
  
  
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  
  function new (string name = "apb_sequencer", uvm_component parent);
    super.new(name, parent);
    `uvm_info("SEQUENCER_CLASS", "Inside Constructor", UVM_LOW) 
  endfunction: new
  
  //---------------------------
  //      BUILD PHASE
  //---------------------------
  

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("SEQUENCER_CLASS", "Build Phase!", UVM_LOW)
  endfunction: build_phase
  
  
  //---------------------------
  //      CONNECT PHASE
  //---------------------------
  
  

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SEQUENCER_CLASS", "Connect Phase!", UVM_LOW)
  endfunction: connect_phase
  

endclass: apb_sequencer






