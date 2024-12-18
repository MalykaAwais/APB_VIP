class apb_driver extends uvm_driver #(apb_packet);

  //------------------------------------------------------------------
  //   apb_sequencer is being parameterized with the type apb_packet  
  //------------------------------------------------------------------
  
  //------------------------------------------------------------------
  //   Parameterizing the sequencer allows for the creation of        
  //   instances  for various transaction types, such as apb_packet   
  //   or axi_packet, without rewriting the entire sequencer class.   
  //------------------------------------------------------------------
  

  `uvm_component_utils(apb_driver)
  
  apb_packet item;
  virtual apb_if vif;

  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new (string name = "apb_driver", uvm_component parent);
    super.new(name, parent);    
    `uvm_info("DRIVER_CLASS", "Inside Constructor", UVM_LOW) 
  endfunction: new

  //---------------------------
  //      BUILD PHASE
  //---------------------------
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("DRIVER_CLASS", "Build Phase!", UVM_LOW)
    if(!(uvm_config_db #(virtual apb_if):: get(this, "*", "vif", vif)))
    begin 
      `uvm_error("DRIVER_CLASS", "Failed to get VIF from configdb")
    end
  endfunction: build_phase
  
  //---------------------------
  //      CONNECT PHASE
  //---------------------------
  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("DRIVER_CLASS", "Connect Phase!", UVM_LOW)
  endfunction: connect_phase
  
  //---------------------------
  //      RUN PHASE
  //---------------------------
  
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("DRIVER_CLASS", "Run Phase!", UVM_LOW)
    
    forever 
      begin
        item = apb_packet :: type_id :: create("item");
        seq_item_port.get_next_item(item);
        `uvm_info(get_type_name(), $sformatf("Sending this packet to DUT:\n%s", item.sprint()), UVM_LOW)
         //driver requests for a sequence item by using get_next_item, and in the arguments comes requested pkt/item, which is initially empty
        
        if (item.pwrite)
          drive_write(item);
        else
        begin
          item.pwdata = 'hx;
          drive_read(item);
      	end
        seq_item_port.item_done();
        vif.penable = 0;
        vif.psel = 0;
        vif.pwdata = 'hx;
        @(negedge vif.clk);
        
      
      end
  endtask: run_phase
  
  //---------------------------
  //      TASK DRIVE()
  //---------------------------
  
  task drive_write(apb_packet item); // since this is object so it is pass by reference
    
    //---------------------------------------------------------------
    //  Copying values of transaction packet into interface fields 
    //---------------------------------------------------------------
    
    //@(negedge vif.clk);
    @(negedge vif.clk);
    vif.rstn = item.rstn;	
    vif.paddr = item.paddr;
    vif.pwdata = item.pwdata;
    vif.penable = 0;
    item.penable = vif.penable;
    vif.pwrite = 1;
    item.pwrite = vif.pwrite;
    vif.psel = item.psel;
    @(negedge vif.clk);
    vif.penable = 1;
    item.penable = vif.penable;
    if(item.rstn)
    begin
		forever
		begin
			`uvm_info(get_type_name(), "Inside Master Driver Loop", UVM_LOW)
			@(negedge vif.clk);
			if(vif.pready)
				break;
                 vif.penable = 1;
    item.penable = vif.penable;
		end
    end
    else
    begin
    	vif.pwdata = 'hx;
    end
 	`uvm_info(get_type_name(), "Outside Master Driver Loop", UVM_LOW)
    //vif.pwdata <= item.pwdata;
    
  endtask: drive_write
  
  task drive_read(apb_packet item); // since this is object so it is pass by reference
    
    //---------------------------------------------------------------
    //  Copying values from transaction packet into interface fields 
    //---------------------------------------------------------------
    @(negedge vif.clk);
    vif.rstn =item.rstn;	
    vif.paddr =item.paddr;
    
    vif.pwrite = 0;
    item.penable = 0;
    vif.penable = item.penable;
    vif.psel = item.psel;
    @(negedge vif.clk);
   vif.penable = 1;
    item.penable = vif.penable;
    if(item.rstn)
    begin
    forever
		begin
			@(negedge vif.clk);
			if(vif.pready)
				break;
               vif.penable = 1;
    item.penable = vif.penable;
		end
	end
  endtask: drive_read

  
endclass: apb_driver






