package Ctrl_reg_pkg;
	
import uvm_pkg::*;
`include "uvm_macros.svh"


class Ctrl_reg extends uvm_reg ;
 `uvm_object_utils(Ctrl_reg);


 rand uvm_reg_field  Ctrl_reg_f ;


covergroup Ctrl_reg_cg();
	option.per_instance = 1;

	coverpoint Ctrl_reg_f.value[3:0];
	// {
  //   bins Lower = {[0:63]};
  //   bins Mid   = {[64:127]};
  //   bins High  = {[128:255]};	
	// }
endgroup


 function new(string name = "Ctrl_reg");
   super.new(name , 4 , UVM_CVR_FIELD_VALS);

   if(has_coverage(UVM_CVR_FIELD_VALS))
   	 Ctrl_reg_cg = new();

 endfunction


//////////////////////// TWO FUNS ADDED FOR COV ///////////////////

virtual function void sample(uvm_reg_data_t data , uvm_reg_data_t byte_en , bit is_read , uvm_reg_map map);
  Ctrl_reg_cg.sample();
endfunction


virtual function void sample_values();
 super.sample_values();                      // TO ENSURE ANY CONFIGURATIONS IN BASE CLASS IS PRESERVED AS DEFAULT
 Ctrl_reg_cg.sample();
endfunction

////////////////////////////////////////////////////////////////////

virtual function void build();
	  Ctrl_reg_f = uvm_reg_field::type_id::create("Ctrl_reg_f");
    Ctrl_reg_f.configure(
    						.parent(this) ,
    					  .lsb_pos(0)   ,
    					  .size(4)      ,
    					  .access("RW") ,
    					  .volatile(0)  ,
    					  .reset('h0)   ,
    					  .has_reset(1) ,
    					  .is_rand(1)   ,
    					  .individually_accessible(1));
endfunction


endclass

endpackage