
import uvm_pkg::*;
import param_pkg::*;
	
	// include the UVM macros
	`include "uvm_macros.svh"

interface apb_if(input bit clk);
  
  logic rstn;
  logic [ADDRESS_WIDTH-1:0] paddr ;
  logic pwrite;
  logic [1:0] psel;
  logic penable;
  logic [DATA_WIDTH-1:0] pwdata;
  logic [DATA_WIDTH-1:0] prdata;
  logic pready;
  bit [DELAY_FOR_PREADY:0]delay;
  // Modports
  modport apb_slave (
    input rstn,
    input paddr,    //can be randomized
    input pwrite,   //can be randomized
    input psel,     //can be randomized
    input penable,  //can be randomized
    input pwdata,   //can be randomized
    output prdata,
    output pready
  );
  
  modport tb (
    output rstn,
    output paddr,
    output pwrite,
    output psel,
    output penable,
    output pwdata,
    input prdata,
    input pready
  );

//=============================================================================================
  // Assertion 1: penable must be high after one cycle when the psel is high
  // -----------------------------------------------------------------------
  // This assertion ensures that penable is high after the one cycle when the psel is asserted.
//=============================================================================================

property penable_high_after_one_cycle_when_psel_high;
  @(negedge clk) disable iff (!rstn) 
    ($rose(psel) && (paddr!=='x) && (pwrite ? (pwdata !== 'x && pwdata !== 'z) : 1)  && (psel==1)) 
    |=> (penable == 1) [*1:$];
endproperty

assert property (penable_high_after_one_cycle_when_psel_high) 
  begin
    `uvm_info("APB_ASSERT_1", "***********> Assertion Passed: penable is high after one cycle when psel is high", UVM_LOW)
  end 
else 
  begin
    if (psel !== 1) 
      `uvm_warning("APB_ASSERT_1", "*> Assertion Failed: psel was not 1")
    else if (!$stable(pwrite)) 
      `uvm_warning("APB_ASSERT_1", "*> Assertion Failed: pwrite was not stable")
    else if (pwrite && (pwdata === 'x || pwdata === 'z)) 
      `uvm_warning("APB_ASSERT_1", "*> Assertion Failed: pwdata was invalid ('x or 'z) while pwrite was 1")
    else 
      `uvm_warning("APB_ASSERT_1", "*> Assertion Failed: penable did not stay high for at least 1 cycle")
  end


//==========================================================================================
  // Assertion 2: waits for the pready signal when the penable is asserted
  // -----------------------------------------------------------------
  // From the moment penable is asserted, pready can become 1 immediately (in the same cycle) or in any future cycle.
//========================================================================================

property pready_high_after_N_clockcycles_of_penable_is_asserted;
  @(posedge clk) disable iff (!rstn)
    ((penable)||($past(penable)))|-> ( ##[0:$] (pready == 1));
endproperty

// Corrected syntax for assert property
assert property (pready_high_after_N_clockcycles_of_penable_is_asserted)
  begin
    `uvm_info("APB_ASSERT_2", "***> Assertion Passed: pready is high after N clock cycles of penable is asserted", UVM_LOW)
  end
else 
  `uvm_warning("APB_ASSERT_2", "*> pready is not high after N clock cycles of penable is asserted")

//=======================================================================
  // Assertion 3: prdata is x when the pwrite is high
  // ---------------------------------------------------
  // This assertion ensures that prdata is x when pwrite is high.
//=======================================================================
 property prdata_is_X_when_pwrite_high;
    @(posedge clk) disable iff (!rstn) ((pwrite) && (pready)) |-> (prdata === 'hx);
  endproperty

  assert property (prdata_is_X_when_pwrite_high)
	begin
	    `uvm_info("APB_ASSERT_3", "***> Assertion Passed: prdata is x when pwrite is high", UVM_LOW)
	  end
    else `uvm_warning("APB_ASSERT_3", "*****>  prdata is not x when pwrite is high")

//========================================================================================
  // Assertion 4: prdata should be valid when pwrite is low
  // -----------------------------------------------------------------------
  // This assertion ensures that prdata can only be non-zero when pwrite is low.
//========================================================================================

  property prdata_valid_when_write_low;
    @(posedge clk) disable iff (!rstn) ((!pwrite) && (pready)) |-> (prdata !== 'hx);
  endproperty

  assert property (prdata_valid_when_write_low)
	begin
	    `uvm_info("APB_ASSERT_4", "***> Assertion Passed: prdata is valid when pwrite is low", UVM_LOW)
	  end
    else `uvm_warning("APB_ASSERT_4", "*****>  prdata is not valid when pwrite is low")


	// Covergroup Declaration
	covergroup apb_cg @(posedge clk); 
    option.per_instance = 1; // Unique coverage per instance
    
	// Custom Cross Coverage for pwdata and paddr
	cp_paddr_pwdata : cross pwdata, paddr;   

    // For paddr, divide the 8-bit address into smaller ranges
    cp_paddr : coverpoint paddr {
      bins low_range  = {[0:63]};  // Bin 1 for addresses 0-63
      bins mid_range  = {[64:127]}; // Bin 2 for addresses 64-127
      bins high_range = {[128:191]}; // Bin 3 for addresses 128-191
      bins upper_range = {[192:255]}; // Bin 4 for addresses 192-255
    }

    cp_pwdata : coverpoint pwdata {
      // Bins for every 16-value range for full 32-bit value
      bins bin_0   = {[0  :15]};
      bins bin_1   = {[16 :31]};
      bins bin_2   = {[32 :47]};
      bins bin_3   = {[48 :63]};
      bins bin_4   = {[64 :79]};
      bins bin_5   = {[80 :95]};
      bins bin_6   = {[96 :111]};
      bins bin_7   = {[112:127]};
      bins bin_8   = {[128:143]};
      bins bin_9   = {[144:159]};
      bins bin_10  = {[160:175]};
      bins bin_11  = {[176:191]};
      bins bin_12  = {[192:207]};
      bins bin_13  = {[208:223]};
      bins bin_14  = {[224:239]};
      bins bin_15  = {[240:255]};
      bins bin_16  = {[256:511]};  // Larger range
      bins bin_17  = {[512:1023]};
      bins bin_18  = {[1024:2047]};
      bins bin_19  = {[2048:4095]};
      bins bin_20  = {[4096:8191]};
      bins bin_21  = {[8192:16383]};
      bins bin_22  = {[16384:32767]};
      bins bin_23  = {[32768:65535]};
      bins bin_24  = {[65536:131071]};
      bins bin_25  = {[131072:262143]};
      bins bin_26  = {[262144:524287]};
      bins bin_27  = {[524288:1048575]};
      bins bin_28  = {[1048576:2097151]};
      bins bin_29  = {[2097152:4194303]};
      bins bin_30  = {[4194304:8388607]};
      bins bin_31  = {[8388608:16777215]};
      bins bin_32  = {[16777216:33554431]};
      bins bin_33  = {[33554432:67108863]};
      bins bin_34  = {[67108864:134217727]};
      bins bin_35  = {[134217728:268435455]};
      bins bin_36  = {[268435456:536870911]};
      bins bin_37  = {[536870912:1073741823]};
      bins bin_38  = {[1073741824:2147483647]};
      bins bin_39  = {[2147483648:4294967000]}; // Max value for 32-bit
    }
    // For pwdata, divide the 8-bit data into smaller bins
      cp_prdata : coverpoint prdata {
      // Bins for every 16-value range for full 32-bit value
      bins bin_0   = {[0  :15]};
      bins bin_1   = {[16 :31]};
      bins bin_2   = {[32 :47]};
      bins bin_3   = {[48 :63]};
      bins bin_4   = {[64 :79]};
      bins bin_5   = {[80 :95]};
      bins bin_6   = {[96 :111]};
      bins bin_7   = {[112:127]};
      bins bin_8   = {[128:143]};
      bins bin_9   = {[144:159]};
      bins bin_10  = {[160:175]};
      bins bin_11  = {[176:191]};
      bins bin_12  = {[192:207]};
      bins bin_13  = {[208:223]};
      bins bin_14  = {[224:239]};
      bins bin_15  = {[240:255]};
      bins bin_16  = {[256:511]};  // Larger range
      bins bin_17  = {[512:1023]};
      bins bin_18  = {[1024:2047]};
      bins bin_19  = {[2048:4095]};
      bins bin_20  = {[4096:8191]};
      bins bin_21  = {[8192:16383]};
      bins bin_22  = {[16384:32767]};
      bins bin_23  = {[32768:65535]};
      bins bin_24  = {[65536:131071]};
      bins bin_25  = {[131072:262143]};
      bins bin_26  = {[262144:524287]};
      bins bin_27  = {[524288:1048575]};
      bins bin_28  = {[1048576:2097151]};
      bins bin_29  = {[2097152:4194303]};
      bins bin_30  = {[4194304:8388607]};
      bins bin_31  = {[8388608:16777215]};
      bins bin_32  = {[16777216:33554431]};
      bins bin_33  = {[33554432:67108863]};
      bins bin_34  = {[67108864:134217727]};
      bins bin_35  = {[134217728:268435455]};
      bins bin_36  = {[268435456:536870911]};
      bins bin_37  = {[536870912:1073741823]};
      bins bin_38  = {[1073741824:2147483647]};
      bins bin_39  = {[2147483648:4294967000]}; // Max value for 32-bit
    }
	
	cp_pwrite  : coverpoint pwrite  { bins on = {1}; bins off = {0}; }
	cp_psel    : coverpoint psel    { bins on = {1}; bins off = {0}; }
	cp_penable : coverpoint penable { bins on = {1}; bins off = {0}; }
	cp_ready : coverpoint pready { bins on = {1}; bins off = {0}; }
  
  
	// Cross-Coverage
	// Cross-coverage of control signals and pwdata bins
	cp_cross_1 : cross cp_pwdata, cp_pwrite;
	cp_cross_2 : cross cp_pwdata, cp_penable;
	cp_cross_3 : cross cp_pwdata, cp_psel;
	cp_cross_4 : cross cp_prdata, cp_psel;
	cp_cross_5 : cross cp_prdata, cp_penable;
	cp_cross_6 : cross cp_prdata, cp_pwrite;
 

	// Intersection of control signals
	cp_intersection : cross cp_pwrite, cp_psel, cp_penable;
    cross_1 : cross cp_psel, cp_penable; // Cross psel and penable
    cross_2 : cross cp_paddr, cp_pwdata; // Cross address and data
    cross_3 : cross cp_psel, cp_penable, cp_pwrite; // Cross psel, penable, and pwrite
	endgroup

	//Instantiating the covergroup
	apb_cg cov_inst = new();

	//Sampling task to trigger the sample of the covergroup
	task sample();
		cov_inst.sample();
	endtask

endinterface
