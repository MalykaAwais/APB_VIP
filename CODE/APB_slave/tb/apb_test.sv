class apb_test extends uvm_test;

  `uvm_component_utils(apb_test)
  
  apb_env env;
  apb_sequence reset_seq;
  apb_active_sequence seq1;
  int count = 1; 
  int c =1;
    virtual apb_interface vif;
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
    

  function new (string name = "apb_test", uvm_component parent);
    super.new(name, parent);    
    `uvm_info("TEST_CLASS", "Inside Constructor", UVM_LOW) 
  endfunction: new


  //---------------------------
  //      BUILD PHASE
  //---------------------------
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TEST_CLASS", "Build Phase!", UVM_LOW)
     env = apb_env :: type_id :: create("env", this);
       if(!(uvm_config_db #(virtual apb_interface):: get(this, "*", "vif", vif)))
    begin 
      `uvm_error("TEST_CLASS", "Failed to get VIF from configdb")
    end
  endfunction: build_phase
  
  
  //---------------------------
  //      CONNECT PHASE
  //---------------------------
  
  

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TEST_CLASS", "Connect Phase!", UVM_LOW)
  endfunction: connect_phase
  
  
  //---------------------------
  //      RUN PHASE
  //---------------------------
  
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("TEST_CLASS", "Run Phase!", UVM_LOW)
    phase.raise_objection(this);

    repeat(2) 
     begin 
    //@(posedge vif.clk);
    reset_seq = apb_sequence :: type_id :: create ("reset_seq");
    reset_seq.start(env.agent.sequencer);
       $display("The %d sequence i.e RESET Sequence is initiated", c);
   // @(posedge vif.clk);
       c++;
     end

    repeat(100) begin 
    seq1 = apb_active_sequence :: type_id :: create("seq1");
    seq1.start(env.agent.sequencer);

      $display("COUNTER VALUE = %d", count);
      count++;
    @(posedge vif.clk);
    end 
    $display("HERE before phase drop");
    @(posedge vif.clk);
    phase.drop_objection(this);
  endtask: run_phase
  
endclass: apb_test






