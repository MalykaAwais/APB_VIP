class apb_slave_packet extends uvm_sequence_item;
  
logic                    clk;
logic                    rstn;
logic [ADDRESS_WIDTH-1:0]              paddr;
logic                    pwrite;
logic [1:0]              psel;
logic                    penable;
logic             [DATA_WIDTH-1:0] pwdata;
rand logic                  [DATA_WIDTH-1:0] prdata;
rand bit		[DELAY_FOR_PREADY-1:0]		 delay;
rand bit				 pready;
  
`uvm_object_utils_begin(apb_slave_packet)
  `uvm_field_int(rstn, UVM_DEFAULT)
  `uvm_field_int(prdata, UVM_DEFAULT)
  `uvm_field_int(pwdata, UVM_DEFAULT)
  `uvm_field_int(paddr, UVM_DEFAULT)
  `uvm_field_int(pwrite, UVM_DEFAULT)
  `uvm_field_int(psel, UVM_DEFAULT)
  `uvm_field_int(penable, UVM_DEFAULT)
  `uvm_field_int(delay, UVM_DEFAULT)
  `uvm_field_int(pready, UVM_DEFAULT)
`uvm_object_utils_end
      
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_slave_packet");
    super.new(name);
  endfunction: new
  
  function string to_string();
    // Convert different data types in the packet to a formatted string
    // For example:
    string result;
    result = $sformatf("clk: %d, rstn: %d, paddr: %d, pwrite: %d, psel: %d, penable: %d, pwdata: %d, prdata: %d", clk, rstn, paddr,pwrite, psel,penable, pwdata,prdata);
    return result;
  endfunction
    
endclass: apb_slave_packet
