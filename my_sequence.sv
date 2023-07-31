package my_sequence_pkg;
	
`include "uvm_macros.svh"


import uvm_pkg::*;

//--------- PACKET ---------------------
class my_transaction extends uvm_sequence_item;

	`uvm_object_utils(my_transaction);


	function new (string name = "");
		super.new(name);
	endfunction


	rand  bit cmd;
	rand  int addr;
	rand  int data;
    logic [7:0] data_out;


	constraint addr_c {addr >= 0 ; addr <= 255;}
	constraint data_c {data >= 0 ; data <= 255;}


endclass



//--------- SEQUENCE ---------------------
class my_sequence extends uvm_sequence#(my_transaction);

	`uvm_object_utils(my_sequence);


	function new (string name = "");
		super.new(name);
	endfunction

    task body;
	repeat(8)begin
	req = my_transaction::type_id::create("req");
        start_item(req);    // When trigger it go to driver and wait the driver say done in 
                            //order to go to end and send another item

        if(!req.randomize()) 
        	`uvm_fatal("My sequence" , "Randomization failed");
        
       /* req.cmd = $random();
        req.data = $random();
        req.addr = $random();
        */


        finish_item(req);
	end

       endtask
endclass

endpackage
