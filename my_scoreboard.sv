`include "uvm_macros.svh"

import my_sequence_pkg::*;

import uvm_pkg ::*;


class my_scoreboard extends  uvm_scoreboard;

`uvm_component_utils(my_scoreboard);

virtual dut_if dut_vif;
logic [7:0] data_prev;
logic cmd_prev;

uvm_analysis_imp#(my_transaction,my_scoreboard) item_collected_export;

my_transaction data_to_check;


function new(string name , uvm_component parent);
  	super.new(name , parent);
  	data_to_check = new();
  	item_collected_export = new("item_collected_export",this);
endfunction


virtual function void write(my_transaction pkt);
   data_to_check = pkt; 
endfunction



function void build_phase (uvm_phase phase);
  super.build_phase(phase);
   	if(!uvm_config_db#(virtual dut_if)::get(this, "", "dut_vif",dut_vif )) begin  // ht2oly ana leh m7tago h2olk 34an al clock
   		 `uvm_fatal("","uvm config get failed");
   		end
endfunction


task run_phase(uvm_phase phase);


@(posedge dut_vif.clock);
data_prev = data_to_check.data;
cmd_prev  = data_to_check.cmd;

forever begin
	@(posedge dut_vif.clock);

	if (data_to_check.data_out != data_prev) begin
	 	  `uvm_error("CHECKER",$sformatf("data not expected data = %2h , data_out = %2h",data_prev,data_to_check.data_out))
	 end 

	else begin
	`uvm_info("CHECKER",$sformatf("Data expected,data = %2h , data_out = %2h",data_prev,data_to_check.data_out),UVM_MEDIUM)
  end  
    data_prev = data_to_check.data;
    cmd_prev = data_to_check.cmd; 

end 

endtask

endclass
