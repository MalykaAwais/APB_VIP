class apb_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(apb_scoreboard)
	
	`uvm_analysis_imp_decl(_master)
	`uvm_analysis_imp_decl(_slave)

	uvm_analysis_imp_master #(apb_packet, apb_scoreboard) master_in; 	
	uvm_analysis_imp_slave #(apb_slave_packet, apb_scoreboard) slave_in;

	int received, success, fail;
	bit [DATA_WIDTH-1:0] mem [0:(ADDRESS_WIDTH**2)-1] = '{default: 'hF};
        bit [DATA_WIDTH-1:0] pread_value;
        bit [DATA_WIDTH-1:0] expected_value;
        bit pwrite_value;

	apb_packet q0[$];
	apb_slave_packet q1[$];


	function new(string name = "apb_scoreboard", uvm_component parent);
		super.new(name,parent);
		master_in = new("master_in", this); 	
		slave_in = new("slave_in", this);
	endfunction

	function void write_master(input apb_packet packet);
		apb_packet mpkt;
		$cast(mpkt, packet.clone());
		if(mpkt.rstn)
		begin
			q0.push_back(mpkt);
			if(mpkt.pwrite) 
			begin
			///EXPECTED VALUE
                         
			  mem[mpkt.paddr] = mpkt.pwdata;
                        end 
			received++;
                 end	
	endfunction
	
	function void write_slave(input apb_slave_packet packet);
		apb_slave_packet spkt;
                apb_packet mpkt;
		$cast(spkt, packet.clone());
                if(spkt.rstn)
		begin
		q1.push_back(spkt);
			if((q1.size() != 0))
		begin
			mpkt = q0.pop_front();
			spkt = q1.pop_front();
                        pwrite_value = mpkt.pwrite;
                        pread_value  = spkt.prdata;
			expected_value = mem[mpkt.paddr];
                     
			if(pwrite_value == 0)
			begin                         
				if (pread_value == expected_value)
				begin
					success++;
				end
				else
					fail++;
			end
                end end
          endfunction


	function void report_phase(uvm_phase phase);
		`uvm_info(get_type_name(), $sformatf("Report: Scoreboard Packet Stats: Received: %0d", received), UVM_LOW)
		`uvm_info(get_type_name(), $sformatf("Report: Scoreboard Packet Stats: Correct: %0d", success), UVM_LOW)
		`uvm_info(get_type_name(), $sformatf("Report: Scoreboard Packet Stats: Bad: %0d", fail), UVM_LOW)
		
	endfunction
endclass
