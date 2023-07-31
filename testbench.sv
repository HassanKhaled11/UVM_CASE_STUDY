`include "uvm_macros.svh"
`include "my_test.sv"

module top;
import uvm_pkg::*;

//---- INSTANTIATE THE INTERFACE ----
dut_if  dut_if1();

//---- CONNECT THE DUT WITH INTERFACE ----
DUT dut (.clock(dut_if1.clock) , .reset(dut_if1.reset) ,.cmd(dut_if1.cmd) ,.data(dut_if1.data),
	        .addr(dut_if1.addr),.data_out(dut_if1.data_out));



//-------- CLOCK GENERATION -----------

initial begin
	dut_if1.clock = 0;
	forever #2 dut_if1.clock = ~ dut_if1.clock;
end


//-------- RESET DESIGN ---------------

initial begin
	dut_if1.reset = 1;
	@(posedge dut_if1.clock);
	dut_if1.reset = 0; 
end


//-------- START TEST ---------------

initial begin
	run_test("my_test");     // WILL RUN ALL TESTS
end


//------ PUT THE INTERFACE IN THE UVM CONFIGURATION DATABASE --------

initial begin
	uvm_config_db#(virtual dut_if) :: set(null,"*","dut_vif",dut_if1);
	//$dumpfiles("dump.vcd");  // GENERATE WAVEFORM
	//$dumpvars(0,top);        // DISPLAY SIGNALS IN TOP Y#NY KOL AL SIGNALS MN AL 2a5er
end


initial begin
	#5000;
	$stop;
end

endmodule	