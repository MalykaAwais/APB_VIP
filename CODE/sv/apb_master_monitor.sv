class apb_monitor extends uvm_monitor;


  `uvm_component_utils(apb_monitor)
  virtual apb_if vif;
  apb_packet item;
  int i;
  bit [DATA_WIDTH-1:0] temp_data;
 bit temp_write;
  //--------------------------------------------------
  //      DECLARATION OF TRANSMITTER PORT OF MONITOR
  //--------------------------------------------------
    
  
  
  // Create an analysis port with the name monitor_port and
  // that can broadcast the packets of type apb_packet 
  uvm_analysis_port # (apb_packet) master_out;
 
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new (string name = "adder_monitor", uvm_component parent);
    super.new(name, parent);
    `uvm_info("MONITOR_CLASS", "Inside Constructor", UVM_LOW) 
  endfunction: new
  

  //---------------------------
  //      BUILD PHASE
  //---------------------------
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("MONITOR_CLASS", "Build Phase!", UVM_LOW)
    master_out = new("master_out",this);
    if(!(uvm_config_db #(virtual apb_if):: get(this, "*", "vif", vif)))
    begin 
      `uvm_error("MONITOR_CLASS", "Failed to get VIF from configdb")
    end
    
  endfunction: build_phase
  
  //---------------------------
  //      CONNECT PHASE
  //---------------------------
  

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("MONITOR_CLASS", "Connect Phase!", UVM_LOW)     
  endfunction: connect_phase
  
  //---------------------------
  //      RUN PHASE
  //---------------------------
  
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("MONITOR_CLASS", "Run Phase!", UVM_LOW)
    
    forever 
      begin
      	//@(posedge vif.clk);
        @(negedge vif.clk);
        item = apb_packet :: type_id :: create("item"); 
        i = 0;
        //@(negedge vif.clk); 
        @(negedge vif.clk);       
        // sample the inputs (receive inputs values from dut interface)
        item.rstn = vif.rstn;
        item.psel = vif.psel;
        item.penable = vif.penable;
        item.pwdata = vif.pwdata;
         temp_data = item.pwdata;
        item.paddr = vif.paddr;
        item.pwrite = vif.pwrite;
       temp_write = item.pwrite;
        item.prdata = vif.prdata;
      //  master_out.write(item);
        if(item.rstn)
        begin
		    //@(negedge vif.clk);
			forever
			begin
                           
		 		@(negedge vif.clk);
                                 
				if(vif.pready)
					break;
		   	end
		    if(!item.pwrite)
		    	item.prdata = vif.prdata;
		end
		
	
        //----------------------------------------
        //  After once clock cycle we get outputs 
        //----------------------------------------
        
        //@(posedge vif.clk);
           //@(posedge vif.clk);
        item.rstn = vif.rstn;
        item.psel = vif.psel;
        item.penable = vif.penable;
         item.pwdata = vif.pwdata;
        item.paddr = vif.paddr;
        item.pwrite = vif.pwrite;
        item.prdata = vif.prdata;
     	             	`uvm_info(get_type_name(), $sformatf("Receiving this packet in Master:\n%s", item.sprint()), UVM_LOW)
        //item.prdata = vif.prdata;
      
      master_out.write(item);
        
      
        
        // Write method call is a non-blocking call
        
      end
  endtask: run_phase
  
  
endclass: apb_monitor






