`include "uvm_macros.svh"
`include "my_env.sv"



import uvm_pkg::*;

class my_test extends uvm_test;
    
  `uvm_component_utils(my_test);


    //-------- DECLARE OBJECTS INTHE TEST ---------------
	my_env env;
	my_sequence seq;


	function new (string name , uvm_component parent);
	super.new(name,parent);
	endfunction


    //------ BUILDING BLOCKS IN THE TEST------------

	function void build_phase (uvm_phase phase);
		super.build_phase(phase);                       // b3ml build l kol al7agat bta3t build phase ally fel parent
        env = my_env::type_id::create("env",this); 
        seq = my_sequence::type_id::create("seq");
	endfunction 



	task run_phase(uvm_phase phase);    // hna b3m start ll scenarios
		phase.raise_objection(this);
        fork
        	begin 
              seq.start(env.agent.sequencer);  // word sequencer here can be change
        	end	

        	begin
        		  #10;
              `uvm_warning("","Hello World");
        	end	
        join

        phase.drop_objection(this);
    endtask

endclass : my_test



