class apb_module_env extends uvm_env;

	`uvm_component_utils(apb_module_env)


	apb_scoreboard apb_scoreboard_handle;

    uvm_analysis_export #(apb_packet) master_export_port;
	uvm_analysis_export #(apb_slave_packet) slave_export_port;


	function new(string name,uvm_component parent);
		super.new(name,parent);
		master_export_port = new("master_export_port", this);
		slave_export_port = new("slave_export_port", this);
		apb_scoreboard_handle = apb_scoreboard::type_id::create("apb_scoreboard_handle",this);
	endfunction

  	
    function void connect_phase(uvm_phase phase);

    master_export_port.connect(apb_scoreboard_handle.master_in);
    slave_export_port.connect(apb_scoreboard_handle.slave_in);
 
    endfunction
endclass
