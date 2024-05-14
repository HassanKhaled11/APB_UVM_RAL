package Reg2_reg_pkg;
	
import uvm_pkg::*;
`include "uvm_macros.svh"


class Reg2_reg extends uvm_reg ;
 `uvm_object_utils(Reg2_reg);


 rand uvm_reg_field  Reg2_reg_f ;



covergroup Reg2_reg_cg();
	option.per_instance = 1;

	coverpoint Reg2_reg_f.value[31:0];
endgroup



 function new(string name = "Reg2_reg");
   super.new(name , 32 , UVM_CVR_FIELD_VALS);

   if(has_coverage(UVM_CVR_FIELD_VALS))
   	 Reg2_reg_cg = new();
 endfunction



//////////////////////// TWO FUNS ADDED FOR COV ///////////////////

virtual function void sample(uvm_reg_data_t data , uvm_reg_data_t byte_en , bit is_read , uvm_reg_map map);
  Reg2_reg_cg.sample();
endfunction


virtual function void sample_values();
 super.sample_values();                      // TO ENSURE ANY CONFIGURATIONS IN BASE CLASS IS PRESERVED AS DEFAULT
 Reg2_reg_cg.sample();
endfunction

////////////////////////////////////////////////////////////////////



virtual function void build();
	Reg2_reg_f = uvm_reg_field::type_id::create("Reg2_reg_f");
  Reg2_reg_f.configure(
  											 .parent(this) ,
    					           .lsb_pos(0)   ,
    					           .size(32)     ,
    					           .access("RW") ,
    					           .volatile(0)  ,
    					           .reset('h0)   ,
    					           .has_reset(1) ,
    					           .is_rand(1)   ,
    					           .individually_accessible(1));

endfunction

endclass

endpackage