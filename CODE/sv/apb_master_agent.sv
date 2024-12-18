
class apb_agent extends uvm_agent;

  `uvm_component_utils(apb_agent)
  
  //---------------------------------------------------------------
  //      Because APB Encloses all of these three components,      
  //      hence instantiation is being done here                   
  //---------------------------------------------------------------
  
  
  apb_sequencer sequencer;
  apb_driver driver;
  apb_monitor monitor;
  
  
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new (string name = "apb_agent", uvm_component parent);
    super.new(name, parent);
    `uvm_info("AGENT_CLASS", "Inside Constructor", UVM_LOW) 
  endfunction: new
  
  
  //---------------------------
  //      BUILD PHASE
  //---------------------------
  

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("AGENT_CLASS", "Build Phase!", UVM_LOW)
    
  //-------------------------------------------------------
  //      DRIVER, MONITOR AND SEQUENCER BEING BUILD HERE   
  //-------------------------------------------------------
  
    
    
    driver = apb_driver :: type_id :: create("driver",this);
    monitor = apb_monitor :: type_id :: create("monitor",this);
    sequencer = apb_sequencer :: type_id :: create("sequencer", this);
    
    
  endfunction: build_phase
  
  
  //---------------------------
  //      CONNECT PHASE
  //---------------------------
  

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("AGENT_CLASS", "Connect Phase!", UVM_LOW)
    
  
  //-------------------------------------------------------------
  //    Communication between drivers and sequencers is typically
  //    achieved through ports and exports.                      
  //-------------------------------------------------------------
      
    
    driver.seq_item_port.connect(sequencer.seq_item_export);
    
    // In the uvm_driver definition, seq_item_pull_port is parameterized which as  a result becomes "seq_item_port". (Requests for items and then receives the responses from the sequencer)
    
    // In the uvm_sequencer definition, seq_item_port_pull_imp is parameterized which as  a result becomes "seq_item_export". (imports pull requests and exports rsp). 
  
  endfunction: connect_phase
  
  //---------------------------
  //      RUN PHASE
  //---------------------------
  

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("AGENT_CLASS", "Run Phase!", UVM_LOW)
  endtask: run_phase
  
endclass: apb_agent






