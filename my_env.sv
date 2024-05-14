package my_env_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_agent_pkg::* ;
import adapter_pkg::*  ;
import Reg_Block_pkg::*;
import my_sequence_item_pkg::*;
import my_scoreboard_pkg::*;



`define create(type , inst_name)  type::type_id::create(inst_name,this);

class my_env extends uvm_env;
  `uvm_component_utils(my_env)


my_agent   agent     ;
adapter    adapt     ;
Reg_Block  reg_block ;
uvm_reg_predictor #(my_sequence_item) predictor_inst;     // ADDING PREDICTOR SO WE CAN PREDICT THE CURRENT STATE OF THE REGISTER
my_scoreboard sco;


  function new (string name = "my_env" , uvm_component parent = null);
     super.new(name , parent);
  endfunction

  
  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
   
   `uvm_info("MY_ENV" , "ENVIRONMENT BUILT" , UVM_LOW);     

   agent = `create(my_agent,"agent");
   adapt = adapter :: type_id :: create("adapt");
   sco   = `create(my_scoreboard,"sco"); 

   reg_block = Reg_Block::type_id::create("reg_block");
   reg_block.build();

   predictor_inst = uvm_reg_predictor #(my_sequence_item) :: type_id :: create("predictor_inst",this);

  endfunction


  function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
      
       reg_block.default_map.set_sequencer(.sequencer(agent.seqr) , .adapter(adapt));
       reg_block.default_map.set_base_addr(0);
       
       predictor_inst.map = reg_block.default_map;
       predictor_inst.adapter = adapt;

       agent.mon.mon_ap.connect(sco.sco_ap);
       agent.mon.mon_ap.connect(predictor_inst.bus_in);

  endfunction
  
endclass


endpackage