`include "uvm_macros.svh"
`include "my_driver.sv"
`include "my_monitor.sv"


import uvm_pkg::*;



class my_agent extends uvm_env;
    
	`uvm_component_utils( my_agent);


    //-------- DECLARE OBJECTS INTHE TEST ---------------
	my_driver driver;
    uvm_sequencer #(my_transaction) sequencer;
    my_monitor monitor;         // mtnsa4 tzwed de w tzwd fel agent al scoreboard w trbthom bb3d fel env or scoreboard


	function new (string name , uvm_component parent);
	super.new(name,parent);
	endfunction


    //------ BUILDING BLOCKS IN THE TEST------------

	function void build_phase (uvm_phase phase);
	super.build_phase(phase);                   // b3ml build l kol al7agat bta3t build phase ally fel parent
    driver = my_driver::type_id::create("driver",this);
    sequencer = uvm_sequencer #(my_transaction):: type_id :: create("sequencer" ,this);
    monitor = my_monitor::type_id::create("monitor",this);
	endfunction 

 
    function void connect_phase (uvm_phase phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction	

endclass 