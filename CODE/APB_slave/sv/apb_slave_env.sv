class apb_slave_env extends uvm_env;

  `uvm_component_utils(apb_slave_env)

  apb_slave_agent agent;
 
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
    
  function new (string name = "apb_slave_env", uvm_component parent);
    super.new(name, parent);
    `uvm_info("Slave_ENV_CLASS", "Inside Constructor", UVM_LOW) 
  endfunction: new

  //---------------------------
  //      BUILD PHASE
  //---------------------------
  

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("Slave_ENV_CLASS", "Build Phase!", UVM_LOW)
    agent = apb_slave_agent :: type_id :: create ("agent", this);
  endfunction: build_phase
  
  //---------------------------
  //      CONNECT PHASE
  //---------------------------
  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("Slave_ENV_CLASS", "Connect Phase!", UVM_LOW);
  endfunction: connect_phase
  
  //---------------------------
  //      RUN PHASE
  //---------------------------
  

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("Slave_ENV_CLASS", "Run Phase!", UVM_LOW)
  endtask: run_phase
  
endclass: apb_slave_env






