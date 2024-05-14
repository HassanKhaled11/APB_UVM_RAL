package Reg_Block_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import Ctrl_reg_pkg::*;
import Reg1_reg_pkg::*;
import Reg2_reg_pkg::*;
import Reg3_reg_pkg::*;
import Reg4_reg_pkg::*;

`define create(type , inst_name)  type::type_id::create(inst_name);

class Reg_Block extends uvm_reg_block;
	`uvm_object_utils(Reg_Block)


Ctrl_reg Ctrl_reg_inst ;
Reg1_reg Reg1_reg_inst ;
Reg2_reg Reg2_reg_inst ;
Reg3_reg Reg3_reg_inst ;
Reg4_reg Reg4_reg_inst ;

  
  function new (string name = "Reg_Block");
  		super.new(name , UVM_CVR_FIELD_VALS);
  endfunction	


  virtual function void build();
  	
  	Ctrl_reg_inst = `create(Ctrl_reg,"Ctrl_reg_inst");
  	Ctrl_reg_inst.build();
  	Ctrl_reg_inst.configure(this,null);

  	Reg1_reg_inst = `create(Reg1_reg,"Reg1_reg_inst");
  	Reg1_reg_inst.build();
  	Reg1_reg_inst.configure(this,null);

  	Reg2_reg_inst = `create(Reg2_reg,"Reg2_reg_inst");
  	Reg2_reg_inst.build();
  	Reg2_reg_inst.configure(this,null);

  	Reg3_reg_inst = `create(Reg3_reg,"Reg3_reg_inst");
  	Reg3_reg_inst.build();
  	Reg3_reg_inst.configure(this,null);

   	Reg4_reg_inst = `create(Reg4_reg,"Reg4_reg_inst");
  	Reg4_reg_inst.build();
  	Reg4_reg_inst.configure(this,null); 	  	  	  	


    uvm_reg::include_coverage("*" , UVM_CVR_ALL);



//-------- DEFINING BACKDOOR ACCESS FOR REG1 --------------
    add_hdl_path ("top.DUT", "RTL");
    Reg1_reg_inst.add_hdl_path_slice("reg1",0,32);  // "NAME IN RTL CODE" , "POSITION" , "SIZE IN BITS"
//----------------------------------------------------------
   

    default_map = create_map("default_map" , 0 , 4 , UVM_LITTLE_ENDIAN);  // NAME , BASE , nBYTES , FIRST BYTE LSB
    
    default_map.add_reg(Ctrl_reg_inst , 'h0  , "RW");                     //ACCESS POLICY SHOULD BE THE SAME IN REG
    default_map.add_reg(Reg1_reg_inst , 'h4  , "RW");
    default_map.add_reg(Reg2_reg_inst , 'h8  , "RW");
    default_map.add_reg(Reg3_reg_inst , 'hC  , "RW");            
    default_map.add_reg(Reg4_reg_inst , 'h10 , "RW");

    default_map.set_auto_predict(0);                                     // DISABLE IMPLICIT PREDICTOR

    lock_model();     //THIS LOCK IS MANDATORY FOR BUILDING THE ADDRESS MAP, LOCK ANY CHANGES TO THE STRUCTURE LIKE ADDING REGISTERS OR MEMORIES

  endfunction 
endclass 


endpackage