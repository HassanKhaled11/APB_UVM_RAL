package adapter_pkg;

 import uvm_pkg::*;
`include "uvm_macros.svh"

import my_sequence_item_pkg::*;


class adapter extends uvm_reg_adapter;
	`uvm_object_utils(adapter)

  function new (string name = "adapter");
  		super.new(name);
  endfunction

  
  virtual function void bus2reg (uvm_sequence_item bus_item , ref uvm_reg_bus_op rw);
  	
  	my_sequence_item item;
  	assert($cast(item , bus_item));
      rw.kind = (item.pwrite == 1)? UVM_WRITE : UVM_READ;
      rw.data = (item.pwrite == 1)? item.pwdata: item.prdata;  // THIS IS BUS2REG SO IT COULD BE DOUT OR DIN 
      rw.addr = item.paddr;
      rw.status = UVM_IS_OK;
  endfunction

 
 virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
 	 my_sequence_item item;

 	 item = my_sequence_item::type_id::create("item");

 	 item.paddr   = rw.addr;
 	 item.pwrite = (rw.kind == UVM_WRITE)? 1'b1 : 1'b0 ;
 	 item.pwdata = rw.data;                 // THIS IS REG TO BUS SO DATA IN ONLY WRITING 

 	 return item;
 endfunction



endclass 



endpackage
