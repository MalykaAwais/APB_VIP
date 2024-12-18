package apb_slave_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
   import param_pkg::*;

  `include "apb_slave_packet.sv"

  `include "apb_slave_monitor.sv"
  `include "apb_slave_sequencer.sv"
  `include "apb_slave_driver.sv"
  `include "apb_slave_agent.sv"
  `include "apb_slave_sequence.sv"

  `include "apb_slave_env.sv"

endpackage : apb_slave_pkg
