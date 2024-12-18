// 64 bit option for AWS labs
-64

-uvmhome /home/cc/mnt/XCELIUM2309/tools/methodology/UVM/CDNS-1.1d

// include directories

-incdir ../sv 
-incdir ../APB_slave/sv

../sv/parameters.sv
../sv/apb_pkg.sv // compile master package
../APB_slave/sv/apb_slave_pkg.sv // compile slave package
../sv/apb_interface.sv

hw_top.sv

tb_top.sv // compile top level 

+UVM_TESTNAME=base_test
+UVM_VERBOSITY=UVM_FULL
+SVSEED=random

-access +rwc +gui +ENBLLV -timescale 1ns/1ns
//-access -coverage all +rwc +gui +ENBLLV -timescale 1ns/1ns
//-access +rwc -timescale 1ns/1ns
