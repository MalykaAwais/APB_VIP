class apb_slave_monitor extends uvm_monitor;


  `uvm_component_utils(apb_slave_monitor)
  virtual apb_if vif;
  apb_slave_packet item;
   int packet_count = 1;
  int num_pkt_col;
  
  //--------------------------------------------------
  //      DECLARATION OF TRANSMITTER PORT OF MONITOR
  //--------------------------------------------------
    
  
  
  // Create an analysis port with the name monitor_port and
  // that can broadcast the packets of type apb_packet 
  uvm_analysis_port # (apb_slave_packet) slave_out;
  

  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new (string name = "apb_monitor", uvm_component parent);
    
    super.new(name, parent);
    `uvm_info("Slave_MONITOR_CLASS", "Inside Constructor", UVM_LOW) 
  endfunction: new
  

  //---------------------------
  //      BUILD PHASE
  //---------------------------
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("Slave_MONITOR_CLASS", "Build Phase!", UVM_LOW)
    slave_out = new("slave_out",this);
    if(!(uvm_config_db #(virtual apb_if):: get(this, "*", "vif", vif)))
    begin 
      `uvm_error("Slave_MONITOR_CLASS", "Failed to get VIF from configdb")
    end
    
  endfunction: build_phase
  
  //---------------------------
  //      CONNECT PHASE
  //---------------------------
  

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("Slave_MONITOR_CLASS", "Connect Phase!", UVM_LOW)     
  endfunction: connect_phase
  
  //---------------------------
  //      RUN PHASE
  //---------------------------
  
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("Slave_MONITOR_CLASS", "Run Phase!", UVM_LOW)
    
    forever 
      begin
      	@(posedge vif.clk);
        @(posedge vif.clk);
        item = apb_slave_packet :: type_id :: create("item");

        @(posedge vif.clk);        
        // sample the inputs (receive inputs values from dut interface)
        item.rstn = vif.rstn;
        item.psel = vif.psel;
        item.penable = vif.penable;
        item.pwdata = vif.pwdata;
        item.paddr = vif.paddr;
        item.pwrite = vif.pwrite;
        item.prdata = vif.prdata;
        
        if(item.rstn)
        begin
		    //@(posedge vif.clk);
			forever
			begin
		 		@(posedge vif.clk);
				if(vif.pready)
					break;
		   	end
		    if(!item.pwrite)
		    	item.prdata = vif.prdata;
		end
        
       `uvm_info(get_type_name(), $sformatf("Receiving this packet in SLAVE===========================================:\n%s ,\n packet no: %d", item.sprint(),packet_count), UVM_LOW)
        packet_count++;
        slave_out.write(item);
        num_pkt_col++;
        
        // Write method call is a non-blocking call
        
      end
  endtask: run_phase

  // UVM report_phase
  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: Slave APB Monitor Collected %0d Packets", num_pkt_col), UVM_LOW)
  endfunction : report_phase

endclass: apb_slave_monitor






