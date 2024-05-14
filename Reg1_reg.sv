package Reg1_reg_pkg;
	
import uvm_pkg::*;
`include "uvm_macros.svh"


class Reg1_reg extends uvm_reg ;
 `uvm_object_utils(Reg1_reg);


 rand uvm_reg_field  Reg1_reg_f ;


covergroup Reg1_reg_cg();
	option.per_instance = 1;

	coverpoint Reg1_reg_f.value[31:0];
	// {
  //   bins Lower = {[0:63]};
  //   bins Mid   = {[64:127]};
  //   bins High  = {[128:255]};	
	// }
endgroup



 function new(string name = "Reg1_reg");
   super.new(name , 32 , UVM_CVR_FIELD_VALS);

   if(has_coverage(UVM_CVR_FIELD_VALS))
   	 Reg1_reg_cg = new();
 endfunction


//////////////////////// TWO FUNS ADDED FOR COV ///////////////////

virtual function void sample(uvm_reg_data_t data , uvm_reg_data_t byte_en , bit is_read , uvm_reg_map map);
  Reg1_reg_cg.sample();
endfunction


virtual function void sample_values();
 super.sample_values();                      // TO ENSURE ANY CONFIGURATIONS IN BASE CLASS IS PRESERVED AS DEFAULT
 Reg1_reg_cg.sample();
endfunction

////////////////////////////////////////////////////////////////////

virtual function void build();
	Reg1_reg_f = uvm_reg_field::type_id::create("Reg1_reg_f");
    Reg1_reg_f.configure( .parent(this) ,
    					  .lsb_pos(0)   ,       // RELATED TO THIS FIELD
    					  .size(32)     ,       // SIZE OF THE FIELD [One Field = size of reg] 
    					  .access("RW") ,       // MOST OF THE TIME RW
    					  .volatile(0)  ,       // [=0 WILL NOT BE CHANGED BETW. TWO TRANSACTIONS] 
    					  .reset('h0)   ,       // THE RESET VALUE OF THE FIELD
    					  .has_reset(1) ,      
    					  .is_rand(1)   ,
    					  .individually_accessible(1));

endfunction



endclass

endpackage