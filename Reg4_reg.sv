package Reg4_reg_pkg;
	
import uvm_pkg::*;
`include "uvm_macros.svh"


class Reg4_reg extends uvm_reg ;
 `uvm_object_utils(Reg4_reg);


 rand uvm_reg_field  Reg4_reg_f ;



covergroup Reg4_reg_cg();
	option.per_instance = 1;

	coverpoint Reg4_reg_f.value[31:0];
	// {
  //   bins Lower = {[0:63]};
  //   bins Mid   = {[64:127]};
  //   bins High  = {[128:255]};	
	// }
endgroup



 function new(string name = "Reg4_reg");
   super.new(name , 32 , UVM_CVR_FIELD_VALS);

   if(has_coverage(UVM_CVR_FIELD_VALS))
   	 Reg4_reg_cg = new();
 endfunction


//////////////////////// TWO FUNS ADDED FOR COV ///////////////////

virtual function void sample(uvm_reg_data_t data , uvm_reg_data_t byte_en , bit is_read , uvm_reg_map map);
  Reg4_reg_cg.sample();
endfunction


virtual function void sample_values();
 super.sample_values();                      // TO ENSURE ANY CONFIGURATIONS IN BASE CLASS IS PRESERVED AS DEFAULT
 Reg4_reg_cg.sample();
endfunction

////////////////////////////////////////////////////////////////////




virtual function void build();
	Reg4_reg_f = uvm_reg_field::type_id::create("Reg4_reg_f");
  Reg4_reg_f.configure(
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