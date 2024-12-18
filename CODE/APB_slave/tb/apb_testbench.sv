
`timescale 1ns/1ns

import uvm_pkg :: *;
`include "uvm_macros.svh" 

//------------------------
//	 include files 
//------------------------


`include "interface.sv"
`include "class_apb_packet.sv"
`include "class_apb_sequence.sv" 
`include "class_apb_monitor.sv"
`include "class_apb_sequencer.sv"
`include "class_apb_scoreboard.sv"
`include "class_apb_driver.sv"
`include "class_apb_agent.sv"
`include "class_apb_env.sv"
`include "class_apb_test.sv"

module tb_apb();
logic clk; 
logic rstn;

  
  //---------------------------------------
  //      INTERFACE AND UUT INSTANTIATION 
  //---------------------------------------
  
 

apb_interface m_apb_if (clk);
 
 

apb_slave uut (m_apb_if); 

  
  //---------------------------------------
  //        SET THE INTERFACE              
  //---------------------------------------
  


  initial 
    begin 
      uvm_config_db #(virtual apb_interface)//the value to pass
      ::set(null, "*", 
            "vif", m_apb_if);
    end
  
    
  //---------------------------------------------
  //      RUN OUR TEST CLASS TO INITATE THE TEST
  //---------------------------------------------
  

  initial
    begin 
      run_test("apb_test");
    end
  
  initial 
    begin 
      clk = 1; 
      rstn = 0;
      #10 rstn = 1;  
    end
  always #5 clk = ~clk;
  
  initial 
    begin
      $dumpfile("dump.vcd");
      $dumpvars();
    end


endmodule
 
