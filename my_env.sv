`include "uvm_macros.svh"
`include "my_agent.sv"
`include "my_scoreboard.sv"


import uvm_pkg::*;

class my_env extends uvm_env;
    
	`uvm_component_utils(my_env);


    //-------- DECLARE OBJECTS INTHE TEST ---------------
	my_agent agent;
	my_scoreboard sb;


	function new (string name , uvm_component parent);
	super.new(name,parent);
	endfunction


    //------ BUILDING BLOCKS IN THE TEST------------

	function void build_phase (uvm_phase phase);
	super.build_phase(phase);                        // b3ml build l kol al7agat bta3t build phase ally fel parent
    agent = my_agent::type_id::create("agent",this);
    sb =  my_scoreboard::type_id::create("sb",this);
	endfunction 


	function void connect_phase (uvm_phase phase);
	agent.monitor.item_collected_port.connect(sb.item_collected_export);	
	endfunction


endclass 