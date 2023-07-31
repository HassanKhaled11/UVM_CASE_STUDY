interface dut_if;

logic clock;
logic reset;
logic cmd;
logic [7:0] addr;
logic [7:0] data;
logic [7:0] data_out;

clocking cb @(posedge clock);

default input #1ps;
input cmd;
input addr;
input data;

endclocking	

endinterface

`include "uvm_macros.svh"


module DUT(
    input clock,
    input reset,
    input cmd,  
    input [7:0] addr,
    input [7:0] data,

    output logic [7:0] data_out
);


import uvm_pkg::*;

always @(posedge clock) begin
	if(reset != 1) begin 
       if(cmd == 1)  
		    data_out <= ~ data;  // la7ez kda hwa h invert al data ally fel cycle ally 2bleha f ht3ml 7sab da fel checking 
           
       else
        data_out <= 1;    
        `uvm_info("DUT" , $sformatf("Recieved cmd = %b , addr = 0x%2h , data = 0x%2h ,data_out = 0x%2h ",
                                  cmd,addr,data,data_out) , UVM_MEDIUM);                
        

	end	
end


endmodule					
