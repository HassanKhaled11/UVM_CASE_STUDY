`include "uvm_macros.svh"
//`include "my_sequence.sv"
import my_sequence_pkg::*;


import uvm_pkg::*;

class my_driver extends uvm_driver #(my_transaction);
    
	`uvm_component_utils( my_driver);


    //-------- DECLARE OBJECTS INTHE TEST ---------------
	virtual dut_if dut_vif;


	function new (string name , uvm_component parent);
	super.new(name,parent);
	endfunction


    //------ BUILDING BLOCKS IN THE TEST------------

	function void build_phase (uvm_phase phase);
	super.build_phase(phase);                   // b3ml build l kol al7agat bta3t build phase ally fel parent
    
    if(!uvm_config_db#(virtual dut_if)::get(this,"","dut_vif",dut_vif))
    	 `uvm_error("","uvm config db get failed");
	endfunction 

    task run_phase(uvm_phase phase);
      
      forever begin
       seq_item_port.get_next_item(req);

       dut_vif.cmd =  req.cmd;      
       dut_vif.addr = req.addr;
       dut_vif.data = req.data;

       @(posedge dut_vif.clock);   // lw mstnt4 hyd5l al inputs kolha wra b3d ,kont momken A7otha fel sequence 3ady 

       seq_item_port.item_done();
      end
    endtask

endclass 