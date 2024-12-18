//===============
// base sequence
//===============

class apb_base_seq extends uvm_sequence #(apb_packet);
  
  // Required macro for sequences automation
  `uvm_object_utils(apb_base_seq)

  // Constructor
  function new(string name="apb_base_seq");
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
endclass : apb_base_seq
//============
// sequence 1
//============

class apb_rst_seq extends apb_base_seq;
  
  `uvm_object_utils(apb_rst_seq)
  
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_rst_seq");
    super.new(name);
    `uvm_info("SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
  
  //---------------------------
  //      TASK BODY()
  //---------------------------
  
  task body();
    `uvm_info("SEQUENCE_CLASS", "Inside Body Task!", UVM_LOW)
		`uvm_do_with(req,{rstn== 0;})
  endtask: body
  
  
endclass: apb_rst_seq
 

  
//============
// sequence 2
//============

  
class apb_active_sequence extends apb_base_seq;

  `uvm_object_utils(apb_active_sequence)
  
  // It refers to the ACCESS Phase either read or write

  
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  
  function new(string name = "apb_active_sequence");
    super.new(name);
    `uvm_info("TEST_SEQUENCE_CLASS", "Inside Constructors", UVM_LOW)
  endfunction
  
  //---------------------------
  //      TASK BODY
  //---------------------------
  
  virtual task body();
    `uvm_info(get_type_name(), "Executing apb_active_sequence sequence", UVM_LOW)
 
      `uvm_do_with(req,{rstn== 1; psel ==1;})
  endtask
    
endclass: apb_active_sequence

//============
// sequence 3
//============

class apb_exhaustive_seq extends apb_base_seq;
	`uvm_object_utils(apb_exhaustive_seq)
	
	apb_rst_seq rst_pkt;
	apb_active_sequence act_pkt;
	
  function new(string name="apb_exhaustive_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "Executing apb_exhaustive_seq sequence", UVM_LOW)
      `uvm_do(rst_pkt)
      repeat(10)
      `uvm_do(act_pkt)
  endtask
  
endclass
 //============
// sequence 4
//============

class singleWrite extends apb_base_seq;
	`uvm_object_utils(singleWrite)
	
	function new(string name = "singleWrite");
		super.new(name);
	endfunction
	
	virtual task body();
		`uvm_info(get_type_name(), "Executing singleWrite sequence", UVM_LOW)
		
		`uvm_do_with(req,{rstn== 1; pwrite==1;})
		
	endtask
	
endclass
//============
// sequence 5
//============

class singleRead extends apb_base_seq;
	`uvm_object_utils(singleRead)
	
	function new(string name = "singleRead");
		super.new(name);
	endfunction
	
	virtual task body();
		`uvm_info(get_type_name(), "Executing singleRead sequence", UVM_LOW)
		
		`uvm_do_with(req,{rstn== 1; pwrite==0;})
		
	endtask
	
endclass
//============
// sequence 6
//============

class ReadAfterWrite extends apb_base_seq;
	`uvm_object_utils(ReadAfterWrite)
	
	function new(string name = "ReadAfterWrite");
		super.new(name);
	endfunction
	
	singleWrite w_seq;
	singleRead r_seq;
	
	virtual task body();
		`uvm_info(get_type_name(), "Executing ReadAfterWrite sequence", UVM_LOW)
		
		//`uvm_do_with(req,{rstn== 1; pwrite==1;})
		//`uvm_do_with(req,{rstn== 1; pwrite==0;})
		`uvm_do(w_seq)
		`uvm_do(r_seq)
		
	endtask
	
endclass
//============
// sequence 7
//============

class BulkReadAfterWrite extends apb_base_seq;
	`uvm_object_utils(BulkReadAfterWrite)
	
	function new(string name = "BulkReadAfterWrite");
		super.new(name);
	endfunction

	//singleWrite w_seq;
	//singleRead r_seq;
	
	apb_packet w_seq;
	
	virtual task body();
		`uvm_info(get_type_name(), "Executing BulkReadAfterWrite sequence", UVM_LOW)
		
		repeat(2)
			begin
			`uvm_do_with(w_seq,{rstn== 1; pwrite==1;})
			 `uvm_create(req)
		          req.paddr.rand_mode(0);
		           req.pwrite.rand_mode(0);
		          req.paddr = w_seq.paddr;
		           req.pwrite = 0;
		          assert(req.randomize());
		          `uvm_send(req) end
	endtask
	
endclass
//============
// sequence 8
//============

class backToBackWrite extends apb_base_seq;
	`uvm_object_utils(backToBackWrite)
	
	function new(string name = "backToBackWrite");
		super.new(name);

	endfunction
	
	singleWrite write_pkt;
	
	virtual task body();
	
		repeat(10)
			`uvm_do(write_pkt)
			
	endtask
		
endclass
//============
// sequence 9
//============

class backToBackRead extends apb_base_seq;
	`uvm_object_utils(backToBackRead)
	
	function new(string name = "backToBackRead");
		super.new(name);

	endfunction
	
	singleRead read_pkt;
	
	virtual task body();
	
		repeat(10)
			`uvm_do(read_pkt)
			
	endtask
		
endclass

//============
// sequence 10
//============

class multipleWriteBrust extends apb_base_seq;
	`uvm_object_utils(multipleWriteBrust)
	
	function new(string name = "multipleWriteBrust");
		super.new(name);
	endfunction
       int curr_paddr;
	virtual task body();
		`uvm_do_with(req,{rstn== 1; pwrite==1;})
		 curr_paddr =  req.paddr;
		  repeat(4) begin
		   curr_paddr++;
		`uvm_do_with(req,{rstn== 1; pwrite==1; paddr==curr_paddr;})	end	
	endtask	
endclass

//============
// sequence 11
//============

class multipleReadBrust extends apb_base_seq;
	`uvm_object_utils(multipleReadBrust)
	
	function new(string name = "multipleReadBrust");
		super.new(name);

	endfunction

       int curr_paddr;
	virtual task body();
		`uvm_do_with(req,{rstn== 1; pwrite==0;})
		 curr_paddr =  req.paddr;
		  repeat(4) begin
		   curr_paddr++;
		`uvm_do_with(req,{rstn== 1; pwrite==0; paddr==curr_paddr;})	end	
	endtask	
endclass



//============
// sequence 12
//============



class slaveDeassertSeq extends apb_base_seq;
	`uvm_object_utils(slaveDeassertSeq)
	
	function new(string name = "slaveDeassertSeq");
		super.new(name);
	endfunction
	
	virtual task body();
		 `uvm_create(req)
	          req.c1.constraint_mode(0);	      
	          assert(req.randomize());
	          req.psel = 0;
	          `uvm_send(req)
	endtask
endclass


//============
// sequence 13
//============




/*class ideal_Cycle_Insertion_Test extends apb_base_seq;
	`uvm_object_utils(ideal_Cycle_Insertion_Test)

	function new(string name = "ideal_Cycle_Insertion_Test");
	
		    super.new(name);
		    	
	endfunction
		
	virtual task body();
		
		 `uvm_create(req)
		 req.c2.constraint_mode(0);
		 assert(req.randomize());		 
	          `uvm_send(req)
	endtask
endclass*/



//============
// sequence 14
//============



/*class Directed_Psel_Selection_Seq extends apb_base_seq;
	`uvm_object_utils(Directed_Psel_Selection_Seq)

	function new(string name = "Directed_Psel_Selection_Seq");	
		    super.new(name);		    	
	endfunction
		
	virtual task body();	
		 `uvm_do_with(req,{psel == 2'b01;}) // slave 1
		 `uvm_do_with(req,{psel == 2'b10;}) // slave 2
		 `uvm_do_with(req,{psel == 2'b11;}) // slave 3
	endtask
endclass*/


//============
// sequence 15
//============



class Randomized_no_of_transaction extends apb_base_seq;
	`uvm_object_utils(Randomized_no_of_transaction)

	function new(string name = "Randomized_no_of_transaction");
	
		    super.new(name);
		    	
	endfunction
		 bit [3:0] n;
	virtual task body();
		// Generate a random integer between 0 and 9
                 n = $urandom() % 10;
		`uvm_info(get_type_name(),$sformatf("No of Transcation :\n%s", n), UVM_LOW)
		 repeat(n)
		   `uvm_do(req)
	endtask
endclass

//============
// sequence 16
//============


class Random_Write_Read_Interleaved extends apb_base_seq;
	`uvm_object_utils(Random_Write_Read_Interleaved)

	function new(string name = "Random_Write_Read_Interleaved");	
		    super.new(name);		    	
	endfunction
		 bit n;
	virtual task body();	
	         n = $urandom();
	         `uvm_create(req);
	         req.randomize();
	         req.pwrite.rand_mode(0);	      
	         req.pwrite = n;
		 `uvm_send(req); 
	endtask
endclass

//============
// sequence 17
//============


class Randomized_PSEL_Assertion extends apb_base_seq;
	`uvm_object_utils(Randomized_PSEL_Assertion)

	function new(string name = "Randomized_PSEL_Assertion");	
		    super.new(name);		    	
	endfunction
		 bit [1:0] n;
	virtual task body();	
	repeat(3) begin
	         n = $urandom();
	         `uvm_create(req);
	         req.randomize();
	         req.psel.rand_mode(0);	      
	         req.psel = n;
		 `uvm_send(req); end
	endtask
endclass

//============
// sequence 18
//============


class Randomized_Burst_Length_with_interleaved_read_write extends apb_base_seq;
	`uvm_object_utils(Randomized_Burst_Length_with_interleaved_read_write)

	function new(string name = "Randomized_Burst_Length_with_interleaved_read_write");	
		    super.new(name);		    	
	endfunction
       int curr_paddr; bit n; bit [4:0] burst;
	virtual task body();
		`uvm_do_with(req,{rstn== 1; pwrite==1;})
		 curr_paddr =  req.paddr;
                  burst = $urandom();
		  repeat(burst) begin
                  n = $urandom();
		  curr_paddr++;
		 `uvm_do_with(req,{rstn== 1; pwrite==n; paddr==curr_paddr;}) end		
	endtask	
endclass


//=============
// sequence 19
//=============

class Directed_singleWrite extends apb_base_seq;
	`uvm_object_utils(Directed_singleWrite)
	
	function new(string name = "Directed_singleWrite");
		super.new(name);
	endfunction
	
	virtual task body();
		`uvm_info(get_type_name(), "Executing Directed_singleWrite sequence", UVM_LOW)
		
		`uvm_do_with(req,{rstn== 1; pwrite==1;paddr ==9;})
		
	endtask
	
endclass
//============
// sequence 20
//============

class Directed_singleRead extends apb_base_seq;
	`uvm_object_utils(Directed_singleRead)
	
	function new(string name = "Directed_singleRead");
		super.new(name);
	endfunction
	
	virtual task body();
		`uvm_info(get_type_name(), "Executing Directed_singleRead sequence", UVM_LOW)
		
		`uvm_do_with(req,{rstn== 1; pwrite==0;paddr ==9;})
		
	endtask
	
endclass

