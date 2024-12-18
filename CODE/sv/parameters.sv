`ifndef PARAM_PKG
`define PARAM_PKG

package param_pkg;
      parameter ADDRESS_WIDTH      = 8; //was 7 in AXI 4 lite
      parameter DATA_WIDTH         = 32;
      parameter DELAY_FOR_PREADY   = 3;
endpackage: param_pkg

`endif
