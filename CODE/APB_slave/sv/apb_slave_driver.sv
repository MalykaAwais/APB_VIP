class apb_slave_driver extends uvm_driver #(apb_slave_packet);

  //------------------------------------------------------------------
  //   apb_sequencer is being parameterized with the type apb_packet  
  //------------------------------------------------------------------
  
  //------------------------------------------------------------------
  //   Parameterizing the sequencer allows for the creation of        
  //   instances  for various transaction types, such as apb_packet   
  //   or axi_packet, without rewriting the entire sequencer class.   
  //------------------------------------------------------------------
  

  `uvm_component_utils(apb_slave_driver)
  
  apb_slave_packet item;
  virtual apb_if vif;
  int i; 
  //------------------------------------------------------
  // MEMORY THAT MIMICS BEHAVIOUR OF SLAVE APB DUT
  //------------------------------------------------------
  bit [DATA_WIDTH-1:0] mem [0:(ADDRESS_WIDTH**2)-1] = '{default: 'hF};
  bit [ADDRESS_WIDTH-1 : 0] memory_address;
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new (string name = "apb_slave_driver", uvm_component parent);
    super.new(name, parent);    
    `uvm_info("Slave_DRIVER_CLASS", "Inside Constructor", UVM_LOW) 
  endfunction: new

  //---------------------------
  //      BUILD PHASE
  //---------------------------
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("Slave_DRIVER_CLASS", "Build Phase!", UVM_LOW)
    if(!(uvm_config_db #(virtual apb_if):: get(this, "*", "vif", vif)))
    begin 
      `uvm_error("Slave_DRIVER_CLASS", "Failed to get VIF from configdb")
    end
  endfunction: build_phase
  
  //---------------------------
  //      CONNECT PHASE
  //---------------------------
  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("Slave_DRIVER_CLASS", "Connect Phase!", UVM_LOW)
  endfunction: connect_phase
  
  //---------------------------
  //      RUN PHASE
  //---------------------------
  
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("Slave_DRIVER_CLASS", "Run Phase!", UVM_LOW)
    
    forever 
      begin
      `uvm_info(get_type_name(), "Slave - START LOOP", UVM_LOW)
      $display("time = %t, pready AT end = %d", $time, vif.pready);
        @(posedge vif.clk); 
        vif.pready = 0;
         
        @(posedge vif.clk);
        vif.prdata = 'hx;
        $display("time = %t, pready AT start = %d", $time, vif.pready);
        if(vif.rstn)
		begin
		`uvm_info(get_type_name(), "Slave - INSIDE RESET", UVM_LOW)
        item = apb_slave_packet :: type_id :: create("item");
        `uvm_info(get_type_name(), "Slave - CREATE Item", UVM_LOW)
        seq_item_port.get_next_item(item);
        $display("time = %t, pready AT ITEM CREATE = %d", $time, item.pready);
        `uvm_info(get_type_name(), "Slave - GOt Item", UVM_LOW)
        vif.delay = item.delay;
        //vif.pready = 0;
		    i = 0;
		   if(vif.psel != 0)
		    begin
		   		`uvm_info(get_type_name(), "Slave - GOt Psel", UVM_LOW)
		   		@(posedge vif.clk);
		    	if(vif.penable)
		    	begin
		   			`uvm_info(get_type_name(), "Slave - GOt Penable", UVM_LOW)
		   			if(item.delay == 0)
		   			begin
		   				item.pready = 1;
		   				$display("time = %t, pready AT item ASSIGNMENT = %d", $time, item.pready);
		   				vif.pready = item.pready;
		   				$display("time = %t, pready AT vif ASSIGNMENT = %d", $time, vif.pready);
		   				//@(posedge vif.clk);
		   				if(vif.pwrite)
		   				begin
		   				///store data===================
							memory_address = vif.paddr;
							mem[memory_address] = vif.pwdata;
		   					vif.prdata = 'hx;
							item.prdata = vif.prdata;
		   				end
		   				else begin
							memory_address = vif.paddr;
		   					item.prdata = mem[memory_address];
							vif.prdata = item.prdata;
		   					//@(posedge vif.clk);
		   			end end
				   	else
				   	begin
				   		i++;
                          
				   		while(i <= item.delay)
				   		begin
				   			@(posedge vif.clk);
				   			`uvm_info(get_type_name(), "Slave - Waiting for Delay", UVM_LOW)
				   			i++;
				   		end
				   		//@(posedge vif.clk);
				   		vif.pready = 1;
				   		item.pready = vif.pready;
				   		if(vif.pwrite)
				   		begin
				   		///store data
							memory_address = vif.paddr;
							mem[memory_address] = vif.pwdata;
		   					vif.prdata = 'hx;
				   		end	
				   		else begin
				   			memory_address = vif.paddr;
		   					item.prdata = mem[memory_address];
							vif.prdata = item.prdata;
				   	end 
 				    end
				end
			end
		    `uvm_info(get_type_name(), $sformatf("Sending this packet to Master:\n%s", item.sprint()), UVM_LOW)
			
		    @(posedge vif.clk);
		    
		    seq_item_port.item_done();
		end
      end
  endtask: run_phase
  
endclass






