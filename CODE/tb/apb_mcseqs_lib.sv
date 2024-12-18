class apb_simple_mcseq extends uvm_sequence;
  
  	// Required macro for sequences automation
  	`uvm_object_utils(apb_simple_mcseq)
	`uvm_declare_p_sequencer(apb_mcsequencer)
	
	apb_rst_seq rst_pkt;
	apb_active_sequence act_pkt;
	apb_no_delay_seq slave_no_delay_pkt;
	//apb_delay_seq slave_delay_pkt;
	
	// Constructor
	function new(string name="apb_simple_mcseq");
		super.new(name);
	endfunction

  task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask : pre_body
  
	virtual task body();
		`uvm_info(get_type_name(), "Executing apb_simple_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)

        fork
		    
				`uvm_do_on(act_pkt, p_sequencer.apb_seqr)
				`uvm_do_on(slave_no_delay_pkt, p_sequencer.apb_slave_seqr)
				//`uvm_do_on(slave_delay_pkt, p_sequencer.apb_slave_seqr)
        join
			
  	endtask  


  task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
  endtask : post_body
endclass
//============
// sequence 1
//============


class apb_single_write_mcseq extends apb_simple_mcseq;
  `uvm_object_utils(apb_single_write_mcseq)
  	singleWrite act_pkt;
	apb_no_delay_seq slave_no_delay_pkt;
        apb_rst_seq rst_pkt;
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_single_write_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
		`uvm_info(get_type_name(), "Executing apb_single_write_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)

		fork	    
		`uvm_do_on(act_pkt, p_sequencer.apb_seqr)
		`uvm_do_on(slave_no_delay_pkt, p_sequencer.apb_slave_seqr)
		join
  	endtask
endclass: apb_single_write_mcseq 
//============
// sequence 2
//============

class apb_single_read_mcseq extends apb_simple_mcseq;
       `uvm_object_utils(apb_single_read_mcseq)
  	singleRead act_pkt;
	apb_no_delay_seq   slave_no_delay_pkt;
	apb_rst_seq rst_pkt;
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_single_read_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
	`uvm_info(get_type_name(), "Executing apb_single_read_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)
		fork	    
		`uvm_do_on(act_pkt, p_sequencer.apb_seqr)
		`uvm_do_on(slave_no_delay_pkt, p_sequencer.apb_slave_seqr)
		join
  	endtask
endclass: apb_single_read_mcseq  
//============
// sequence 3
//============

class apb_read_after_write_mcseq extends apb_simple_mcseq;
       `uvm_object_utils(apb_read_after_write_mcseq)
  	singleWrite act_pkt1;
        singleRead act_pkt;
	apb_no_delay_seq   slave_no_delay_pkt;
	apb_rst_seq rst_pkt;

  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_read_after_write_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
	`uvm_info(get_type_name(), "Executing apb_read_after_write_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)
		fork	    
		`uvm_do_on(act_pkt1, p_sequencer.apb_seqr)
		`uvm_do_on(slave_no_delay_pkt, p_sequencer.apb_slave_seqr)
		`uvm_do_on(act_pkt, p_sequencer.apb_seqr)
        `uvm_do_on(slave_no_delay_pkt, p_sequencer.apb_slave_seqr)
		join
  	endtask
endclass: apb_read_after_write_mcseq



//============
// sequence 4
//============

class apb_BULK_read_after_write_mcseq extends apb_simple_mcseq;
       `uvm_object_utils(apb_BULK_read_after_write_mcseq)
  	singleWrite act_pkt1;
    singleRead act_pkt;
	apb_no_delay_seq   slave_no_delay_pkt;
	apb_rst_seq rst_pkt;

  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_BULK_read_after_write_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
	`uvm_info(get_type_name(), "Executing apb_BULK_read_after_write_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)
	repeat(20) begin
		fork	    
		`uvm_do_on(act_pkt1, p_sequencer.apb_seqr)
		`uvm_do_on(slave_no_delay_pkt, p_sequencer.apb_slave_seqr)
		`uvm_do_on(act_pkt, p_sequencer.apb_seqr)
        `uvm_do_on(slave_no_delay_pkt, p_sequencer.apb_slave_seqr)
		join
       end
  	endtask
endclass: apb_BULK_read_after_write_mcseq

//============
// sequence 5
//============

class apb_backToBackWrite_mcseq extends apb_simple_mcseq;
       `uvm_object_utils(apb_backToBackWrite_mcseq)
  	singleWrite act_pkt1;
        //singleRead act_pkt;
	apb_no_delay_seq   slave_no_delay_pkt;
	apb_rst_seq rst_pkt;

  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_backToBackWrite_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
	`uvm_info(get_type_name(), "Executing apb_backToBackWrite_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)
	repeat(10) begin
		fork	    
		`uvm_do_on(act_pkt1, p_sequencer.apb_seqr)
                `uvm_do_on(slave_no_delay_pkt, p_sequencer.apb_slave_seqr)
		join
       end
  	endtask
endclass: apb_backToBackWrite_mcseq 
//============
// sequence 6
//============

class apb_backToBackRead_mcseq extends apb_simple_mcseq;
       `uvm_object_utils(apb_backToBackRead_mcseq)
  	//singleWrite act_pkt1;
        singleRead act_pkt;
	apb_no_delay_seq   slave_no_delay_pkt;
	apb_rst_seq rst_pkt;

  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_backToBackRead_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
	`uvm_info(get_type_name(), "Executing apb_backToBackRead_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)
	repeat(3) begin
		fork	    
		`uvm_do_on(act_pkt, p_sequencer.apb_seqr)
		`uvm_do_on(slave_no_delay_pkt, p_sequencer.apb_slave_seqr)
		
		join
       end
  	endtask
endclass: apb_backToBackRead_mcseq 
//============
// sequence 7
//============

class apb_slaveDeassertSeq_mcseq extends apb_simple_mcseq;
       `uvm_object_utils(apb_slaveDeassertSeq_mcseq)
  	//singleWrite act_pkt1;
        slaveDeassertSeq act_pkt;
	apb_no_delay_seq   slave_no_delay_pkt;
	apb_rst_seq rst_pkt;

  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_slaveDeassertSeq_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
	`uvm_info(get_type_name(), "Executing apb_slaveDeassertSeq_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)
	repeat(3) begin
		fork	    
		`uvm_do_on(act_pkt, p_sequencer.apb_seqr)
		`uvm_do_on(slave_no_delay_pkt, p_sequencer.apb_slave_seqr)
		join
       end
  	endtask
endclass: apb_slaveDeassertSeq_mcseq 
//============
// sequence 8
//============

class apb_Randomized_no_of_transaction_mcseq extends apb_simple_mcseq;
       `uvm_object_utils(apb_Randomized_no_of_transaction_mcseq)
  	//singleWrite act_pkt1;
        apb_active_sequence act_pkt;
	apb_no_delay_seq   slave_no_delay_pkt;
	apb_rst_seq rst_pkt;
         bit [3:0] n;
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_Randomized_no_of_transaction_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
        n = $urandom() % 10;
	`uvm_info(get_type_name(), "Executing apb_Randomized_no_of_transaction_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)
	repeat(n) begin
		fork	    
			`uvm_do_on(act_pkt, p_sequencer.apb_seqr)
			`uvm_do_on(slave_no_delay_pkt, p_sequencer.apb_slave_seqr)
		join
       end
  	endtask
endclass: apb_Randomized_no_of_transaction_mcseq 
//============
// sequence 9
//============

class apb_Random_Write_Read_Interleaved_mcseq extends apb_simple_mcseq;
       `uvm_object_utils(apb_Random_Write_Read_Interleaved_mcseq)
  	//singleWrite act_pkt1;
        apb_active_sequence act_pkt;
	apb_no_delay_seq   slave_no_delay_pkt;
	apb_rst_seq rst_pkt;
         bit [8:0] n;
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_Random_Write_Read_Interleaved_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
        n = $urandom() % 10;
	`uvm_info(get_type_name(), "Executing apb_Random_Write_Read_Interleaved_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)
	repeat(n) begin
		fork	    
			`uvm_do_on(act_pkt, p_sequencer.apb_seqr)
			`uvm_do_on(slave_no_delay_pkt, p_sequencer.apb_slave_seqr)
		join
       end
  	endtask
endclass: apb_Random_Write_Read_Interleaved_mcseq 


//============
// sequence 10
//============


class apb_single_write_with_delayed_pready_mcseq extends apb_simple_mcseq;
  `uvm_object_utils(apb_single_write_with_delayed_pready_mcseq)
  	singleWrite act_pkt;
	apb_delay_seq slave_delay_pkt;
        apb_rst_seq rst_pkt;
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_single_write_with_delayed_pready_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
		`uvm_info(get_type_name(), "Executing apb_single_write_with_delayed_pready_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)

		fork	    
		`uvm_do_on(act_pkt, p_sequencer.apb_seqr)
		`uvm_do_on(slave_delay_pkt, p_sequencer.apb_slave_seqr)
		join
  	endtask
endclass: apb_single_write_with_delayed_pready_mcseq 
//============
// sequence 11
//============

class apb_single_read_with_delayed_pready_mcseq extends apb_simple_mcseq;
       `uvm_object_utils(apb_single_read_with_delayed_pready_mcseq)
  	singleRead act_pkt;
	apb_delay_seq slave_delay_pkt;
	apb_rst_seq rst_pkt;
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_single_read_with_delayed_pready_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
	`uvm_info(get_type_name(), "Executing apb_single_read_with_delayed_pready_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)
		fork	    
		`uvm_do_on(act_pkt, p_sequencer.apb_seqr)
		`uvm_do_on(slave_delay_pkt, p_sequencer.apb_slave_seqr)
		join
  	endtask
endclass: apb_single_read_with_delayed_pready_mcseq  
//============
// sequence 12
//============

class apb_read_after_write_with_delayed_pready_mcseq extends apb_simple_mcseq;
       `uvm_object_utils(apb_read_after_write_with_delayed_pready_mcseq)
  	singleWrite act_pkt1;
        singleRead act_pkt;
	apb_delay_seq slave_delay_pkt;
	apb_rst_seq rst_pkt;

  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_read_after_write_with_delayed_pready_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
	`uvm_info(get_type_name(), "Executing apb_read_after_write_with_delayed_pready_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)
		fork	    
		`uvm_do_on(act_pkt, p_sequencer.apb_seqr)
		`uvm_do_on(slave_delay_pkt, p_sequencer.apb_slave_seqr)
		`uvm_do_on(act_pkt1, p_sequencer.apb_seqr)
                `uvm_do_on(slave_delay_pkt, p_sequencer.apb_slave_seqr)
		join
  	endtask
endclass: apb_read_after_write_with_delayed_pready_mcseq
//============
// sequence 13
//============

class apb_BULK_read_after_write_with_delayed_pready_mcseq extends apb_simple_mcseq;
       `uvm_object_utils(apb_BULK_read_after_write_with_delayed_pready_mcseq)
  	singleWrite act_pkt1;
        singleRead act_pkt;
	apb_delay_seq slave_delay_pkt;
	apb_rst_seq rst_pkt;

  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_BULK_read_after_write_with_delayed_pready_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
	`uvm_info(get_type_name(), "Executing apb_BULK_read_after_write_with_delayed_pready_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)
	repeat(3) begin
		fork	    
		`uvm_do_on(act_pkt1, p_sequencer.apb_seqr)
		`uvm_do_on(slave_delay_pkt, p_sequencer.apb_slave_seqr)
		`uvm_do_on(act_pkt, p_sequencer.apb_seqr)
                `uvm_do_on(slave_delay_pkt, p_sequencer.apb_slave_seqr)
		join
       end
  	endtask
endclass: apb_BULK_read_after_write_with_delayed_pready_mcseq

//============
// sequence 14
//============

class apb_backToBackWrite_with_delayed_pready_mcseq extends apb_simple_mcseq;
       `uvm_object_utils(apb_backToBackWrite_with_delayed_pready_mcseq)
  	singleWrite act_pkt1;
        //singleRead act_pkt;
	apb_delay_seq slave_delay_pkt;
	apb_rst_seq rst_pkt;

  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_backToBackWrite_with_delayed_pready_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
	`uvm_info(get_type_name(), "Executing apb_backToBackWrite_with_delayed_pready_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)
	repeat(3) begin
		fork	    
		`uvm_do_on(act_pkt1, p_sequencer.apb_seqr)
        `uvm_do_on(slave_delay_pkt, p_sequencer.apb_slave_seqr)
		join
       end
  	endtask
endclass: apb_backToBackWrite_with_delayed_pready_mcseq 
//============
// sequence 15
//============

class apb_backToBackRead_with_delayed_pready_mcseq extends apb_simple_mcseq;
       `uvm_object_utils(apb_backToBackRead_with_delayed_pready_mcseq)
  	//singleWrite act_pkt1;
        singleRead act_pkt;
	apb_delay_seq slave_delay_pkt;
	apb_rst_seq rst_pkt;

  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_backToBackRead_with_delayed_pready_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
	`uvm_info(get_type_name(), "Executing apb_backToBackRead_with_delayed_pready_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)
	repeat(3) begin
		fork	    
		`uvm_do_on(act_pkt, p_sequencer.apb_seqr)
		`uvm_do_on(slave_delay_pkt, p_sequencer.apb_slave_seqr)
		
		join
       end
  	endtask
endclass: apb_backToBackRead_with_delayed_pready_mcseq 
//============
// sequence 16
//============

class apb_slaveDeassertSeq_with_delayed_pready_mcseq extends apb_simple_mcseq;
       `uvm_object_utils(apb_slaveDeassertSeq_with_delayed_pready_mcseq)
  	//singleWrite act_pkt1;
        slaveDeassertSeq act_pkt;
	apb_delay_seq slave_delay_pkt;
	apb_rst_seq rst_pkt;

  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_slaveDeassertSeq_with_delayed_pready_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
	`uvm_info(get_type_name(), "Executing apb_slaveDeassertSeq_with_delayed_pready_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)
	repeat(3) begin
		fork	    
		`uvm_do_on(act_pkt, p_sequencer.apb_seqr)
		`uvm_do_on(slave_delay_pkt, p_sequencer.apb_slave_seqr)
		join
       end
  	endtask
endclass: apb_slaveDeassertSeq_with_delayed_pready_mcseq 
//============
// sequence 17
//============

class apb_Randomized_no_of_transaction_with_delayed_pready_mcseq extends apb_simple_mcseq;
       `uvm_object_utils(apb_Randomized_no_of_transaction_with_delayed_pready_mcseq)
  	//singleWrite act_pkt1;
        apb_active_sequence act_pkt;
	apb_delay_seq slave_delay_pkt;
	apb_rst_seq rst_pkt;
         bit [3:0] n;
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_Randomized_no_of_transaction_with_delayed_pready_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
        n = $urandom() % 10;
	`uvm_info(get_type_name(), "Executing apb_Randomized_no_of_transaction_with_delayed_pready_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)
	repeat(n) begin
		fork	    
			`uvm_do_on(act_pkt, p_sequencer.apb_seqr)
			`uvm_do_on(slave_delay_pkt, p_sequencer.apb_slave_seqr)
		join
       end
  	endtask
endclass: apb_Randomized_no_of_transaction_with_delayed_pready_mcseq 

//============
// sequence 18
//============

class apb_Random_Write_Read_Interleaved_with_delayed_pready_mcseq extends apb_simple_mcseq;
       `uvm_object_utils(apb_Random_Write_Read_Interleaved_with_delayed_pready_mcseq)
  	//singleWrite act_pkt1;
        apb_active_sequence act_pkt;
	apb_delay_seq slave_delay_pkt;
	apb_rst_seq rst_pkt;
         bit [8:0] n;
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_Random_Write_Read_Interleaved_with_delayed_pready_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
        n = $urandom() % 10;
	`uvm_info(get_type_name(), "Executing apb_Random_Write_Read_Interleaved_with_delayed_pready_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)
	repeat(n) begin
		fork	    
			`uvm_do_on(act_pkt, p_sequencer.apb_seqr)
			`uvm_do_on(slave_delay_pkt, p_sequencer.apb_slave_seqr)
		join
       end
  	endtask
endclass: apb_Random_Write_Read_Interleaved_with_delayed_pready_mcseq 

//============
// sequence 19
//============

class apb_BULK_read_after_write_with_no_delay_and_delayed_pready_mcseq extends apb_simple_mcseq;
       `uvm_object_utils(apb_BULK_read_after_write_with_no_delay_and_delayed_pready_mcseq)
  	singleWrite act_pkt1;
        singleRead act_pkt;
        apb_no_delay_seq slave_no_delay_pkt;
	apb_delay_seq slave_delay_pkt;
	apb_rst_seq rst_pkt;

  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_BULK_read_after_write_with_no_delay_and_delayed_pready_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
	`uvm_info(get_type_name(), "Executing apb_BULK_read_after_write_with_no_delay_and_delayed_pready_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)
	repeat(3) begin
		fork	    
		`uvm_do_on(act_pkt1, p_sequencer.apb_seqr)
		`uvm_do_on(slave_no_delay_pkt, p_sequencer.apb_slave_seqr)
		`uvm_do_on(act_pkt, p_sequencer.apb_seqr)
                `uvm_do_on(slave_delay_pkt, p_sequencer.apb_slave_seqr)
		join
       end
  	endtask
endclass: apb_BULK_read_after_write_with_no_delay_and_delayed_pready_mcseq


//=============
// sequence 20
//=============

class apb_write_then_read_on_same_address_mcseq extends apb_simple_mcseq;
       `uvm_object_utils(apb_write_then_read_on_same_address_mcseq)
  	Directed_singleWrite act_pkt1;
        Directed_singleRead act_pkt;
	apb_no_delay_seq   slave_no_delay_pkt;
	apb_rst_seq rst_pkt;

  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_write_then_read_on_same_address_mcseq");
    super.new(name);
    `uvm_info("MULTI_CHANNEL_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
    
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
	virtual task body();
	`uvm_info(get_type_name(), "Executing apb_write_then_read_on_same_address_mcseq sequence", UVM_LOW)
      
        `uvm_do_on(rst_pkt, p_sequencer.apb_seqr)
		//repeat(2) begin
             fork	    
		`uvm_do_on(act_pkt1, p_sequencer.apb_seqr)
		`uvm_do_on(slave_no_delay_pkt, p_sequencer.apb_slave_seqr)
		`uvm_do_on(act_pkt, p_sequencer.apb_seqr)
                `uvm_do_on(slave_no_delay_pkt, p_sequencer.apb_slave_seqr)
		join //end
  	endtask
endclass: apb_write_then_read_on_same_address_mcseq
