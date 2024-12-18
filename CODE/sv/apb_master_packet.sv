class apb_packet extends uvm_sequence_item;
  
rand logic                    clk;
rand logic                    rstn;
rand logic [ADDRESS_WIDTH-1:0]              paddr;
rand logic                    pwrite;
rand logic [1:0]              psel;
rand logic                    penable;
rand logic             [DATA_WIDTH-1:0] pwdata;
logic                  [DATA_WIDTH-1:0] prdata;
  
`uvm_object_utils_begin(apb_packet)
  `uvm_field_int(rstn, UVM_DEFAULT)
  `uvm_field_int(prdata, UVM_DEFAULT)
  `uvm_field_int(pwdata, UVM_DEFAULT)
  `uvm_field_int(paddr, UVM_DEFAULT)
  `uvm_field_int(pwrite, UVM_DEFAULT)
  `uvm_field_int(psel, UVM_DEFAULT)
  `uvm_field_int(penable, UVM_DEFAULT)
`uvm_object_utils_end
      
    constraint c1 {psel == 1;}
  //  constraint c2 {pwdata <= 1023;}
  //---------------------------
  //      CONSTRUCTORS
  //---------------------------
  
  function new(string name = "apb_packet");
    super.new(name);
  endfunction: new
  
  function string to_string();
    // Convert different data types in the packet to a formatted string
    // For example:
    string result;
    result = $sformatf("clk: %d, rstn: %d, paddr: %d, pwrite: %d, psel: %d, penable: %d, pwdata: %d, prdata: %d", clk, rstn, paddr,pwrite, psel,penable, pwdata,prdata);
    return result;
  endfunction
    
endclass: apb_packet
