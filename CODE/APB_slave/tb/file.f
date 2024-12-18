// 64 bit option for AWS labs
-64

-uvmhome /home/cc/mnt/XCELIUM2309/tools/methodology/UVM/CDNS-1.1d


-incdir ../sv // include directory for sv files

// compile files

../sv/parameters.sv
../sv/apb_pkg.sv // compile apb package
../sv/apb_interface.sv



hw_top.sv

tb_top.sv 

+UVM_TESTNAME=base_test
+UVM_VERBOSITY=UVM_FULL
+SVSEED=random

-access +rwc -timescale 1ns/1ns
