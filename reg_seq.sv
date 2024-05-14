package reg_seq_pkg ;

import uvm_pkg::*;
`include "uvm_macros.svh"

import Reg_Block_pkg::*;

class ctrlw_seq extends uvm_sequence;
	`uvm_object_utils(ctrlw_seq)

   Reg_Block reg_block;

	function new(string name = "ctrlw_seq");
        super.new(name);
	endfunction

    task body();

      uvm_status_e  status;
      bit [3:0] wdata;

      for(int i = 0 ; i < 10000 ; i++) begin
      	wdata = $random();
      	reg_block.Ctrl_reg_inst.write(status,wdata);
      end

    endtask

endclass


///////////////////////////////////////

class ctrlrd_seq extends uvm_sequence;
	`uvm_object_utils(ctrlrd_seq)

   Reg_Block reg_block;

	function new(string name = "ctrlrd_seq");
        super.new(name);
	endfunction

    task body();

      uvm_status_e  status;
      bit [3:0] rdata;

      for(int i = 0 ; i < 10000 ; i++) begin
      	 reg_block.Ctrl_reg_inst.read(status,rdata);
      end

    endtask

endclass


////////////////////////////////////////


class reg1wr_seq extends uvm_sequence;
  `uvm_object_utils(reg1wr_seq)

   Reg_Block reg_block;

  function new(string name = "reg1wr_seq");
        super.new(name);
  endfunction

    task body();

      uvm_status_e  status;
      bit [31:0] wdata;

      for(int i = 0 ; i < 10000 ; i++) begin
         wdata = $random();
         reg_block.Reg1_reg_inst.write(status,wdata,UVM_FRONTDOOR);   // UVM_FRONTDOOR AS IT IS CONFIGURED TO BE BACKDOOR ACCESSED
      end

    endtask

endclass

////////////////////////////////////////

class reg1rd_seq extends uvm_sequence;
  `uvm_object_utils(reg1rd_seq)

   Reg_Block reg_block;

  function new(string name = "reg1rd_seq");
        super.new(name);
  endfunction

    task body();

      uvm_status_e  status;
      bit [31:0] rdata;

      for(int i = 0 ; i < 10000; i++) begin
         reg_block.Reg1_reg_inst.read(status,rdata);
      end

    endtask

endclass

////////////////////////////////////////


class reg2wr_seq extends uvm_sequence;
  `uvm_object_utils(reg2wr_seq)

   Reg_Block reg_block;

  function new(string name = "reg2wr_seq");
        super.new(name);
  endfunction

    task body();

      uvm_status_e  status;
      bit [31:0] wdata;

      for(int i = 0 ; i < 10000 ; i++) begin
         //wdata = $random();
         reg_block.Reg2_reg_inst.randomize();        //ANOTHER WAY FOR RANDOMIZATION [MAKE SURE U ENABLED RANDOMIZATION FOR THE FIELD IN REG]
         reg_block.Reg2_reg_inst.write(status,reg_block.Reg2_reg_inst.Reg2_reg_f.value);
      end

    endtask

endclass

////////////////////////////////////////

class reg2rd_seq extends uvm_sequence;
  `uvm_object_utils(reg2rd_seq)

   Reg_Block reg_block;

  function new(string name = "reg2rd_seq");
        super.new(name);
  endfunction

    task body();

      uvm_status_e  status;
      bit [31:0] rdata;

      for(int i = 0 ; i < 10000; i++) begin
         reg_block.Reg2_reg_inst.read(status,rdata);
      end

    endtask

endclass


////////////////////////////////////////


class reg3wr_seq extends uvm_sequence;
  `uvm_object_utils(reg3wr_seq)

   Reg_Block reg_block;
   uvm_reg_data_t Ref_data;

  function new(string name = "reg3wr_seq");
        super.new(name);
  endfunction

    task body();

      uvm_status_e  status;
      bit [31:0] wdata;

      for(int i = 0 ; i < 10000 ; i++) begin
         wdata = $random();
         reg_block.Reg3_reg_inst.write(status,wdata);
      end

//-------------- PRACTICING SET() & GET() CHANGE DESIRED VALUE ------------------
       $display("-----------------SET() & GET() CHANGE DESIRED VALUE-----------------------");

       Ref_data = reg_block.Reg3_reg_inst.get();
       `uvm_info("REG3_SEQ" , $sformatf("DESIRED VALUE = %0h",Ref_data),UVM_LOW);
       Ref_data = reg_block.Reg3_reg_inst.get_mirrored_value();
       `uvm_info("REG3_SEQ" , $sformatf("MIRRORED VALUE = %0h",Ref_data),UVM_LOW);

       reg_block.Reg3_reg_inst.set(32'hBCBCBCBC);

       Ref_data = reg_block.Reg3_reg_inst.get();
       `uvm_info("REG3_SEQ AFTER (SET) DESIRED" , $sformatf("DESIRED VALUE = %0h",Ref_data),UVM_LOW);
       Ref_data = reg_block.Reg3_reg_inst.get_mirrored_value();
       `uvm_info("REG3_SEQ AFTER (SET) DESIRED" , $sformatf("MIRRORED VALUE = %0h",Ref_data),UVM_LOW);

        $display("-------------------------------------------------------------------------");
   
        $display("----------------- AFTER UPDATE() ----------------------------------------");

        reg_block.Reg3_reg_inst.update(status);      // THE UPDATE SEE THE DIFFERENCE BET. DESIRED-MIRRORED..
                                                     //SO It INITIATES A WRITE OP the RTL REG AND THEREFORE UPDATES MIRROR   

       Ref_data = reg_block.Reg3_reg_inst.get();
       `uvm_info("REG3_SEQ AFTER (UPDATE)" , $sformatf("DESIRED VALUE = %0h",Ref_data),UVM_LOW);
       Ref_data = reg_block.Reg3_reg_inst.get_mirrored_value();
       `uvm_info("REG3_SEQ AFTER (UPDATE)" , $sformatf("MIRRORED VALUE = %0h",Ref_data),UVM_LOW);

       $display("-------------------------------------------------------------------------");
   

//------------------------------------------------------------------------------- 

    endtask

endclass

////////////////////////////////////////

class reg3rd_seq extends uvm_sequence;
  `uvm_object_utils(reg3rd_seq)

   Reg_Block reg_block;

  function new(string name = "reg3rd_seq");
        super.new(name);
  endfunction

    task body();

      uvm_status_e  status;
      bit [31:0] rdata;

      for(int i = 0 ; i < 10000; i++) begin
         reg_block.Reg3_reg_inst.read(status,rdata);
      end

    endtask

endclass

////////////////////////////////////////


class reg4wr_seq extends uvm_sequence;
  `uvm_object_utils(reg4wr_seq)

   Reg_Block reg_block;

   bit Rst_status;
   uvm_reg_data_t Ref_data;

  function new(string name = "reg4wr_seq");
        super.new(name);
  endfunction

    task body();

      uvm_status_e  status;
      bit [31:0] wdata;

      for(int i = 0 ; i < 10000 ; i++) begin
         wdata = $random();
         reg_block.Reg4_reg_inst.write(status,wdata);
      end


//-------------- PRACTICING SET() & GET() CHANGE DESIRED VALUE ------------------
       $display("------------------------- RESET() --------------------------------------");

       Ref_data = reg_block.Reg4_reg_inst.get();
       `uvm_info("REG4_SEQ BEFORE RESET" , $sformatf("DESIRED VALUE = %0h",Ref_data),UVM_LOW);
       Ref_data = reg_block.Reg4_reg_inst.get_mirrored_value();
       `uvm_info("REG4_SEQ BEFORE RESET" , $sformatf("MIRRORED VALUE = %0h",Ref_data),UVM_LOW);

       Rst_status = reg_block.Reg4_reg_inst.has_reset();
       `uvm_info("REG4_SEQ RESET STATUS [has_reset()]" , $sformatf("Rst_status = %0h",Rst_status),UVM_LOW);

       `uvm_info("REG4_SEQ RESET VALUE [get_reset()]" , $sformatf("Rst_value = %0h",reg_block.Reg4_reg_inst.get_reset()),UVM_LOW);

       $display("------------------------- VALUES AFTER RESET() ----------------------------");

       reg_block.Reg4_reg_inst.reset();

       Ref_data = reg_block.Reg4_reg_inst.get();
       `uvm_info("REG4_SEQ AFTER (RESET) DESIRED" , $sformatf("DESIRED VALUE = %0h",Ref_data),UVM_LOW);
       Ref_data = reg_block.Reg4_reg_inst.get_mirrored_value();
       `uvm_info("REG4_SEQ AFTER (RESET) DESIRED" , $sformatf("MIRRORED VALUE = %0h",Ref_data),UVM_LOW);

       `uvm_info("REG4_SEQ AFTER RESET VALUE [get_reset()]" , $sformatf("Rst_value = %0h",reg_block.Reg4_reg_inst.get_reset()),UVM_LOW);


      $display("-------------------------------------------------------------------------");


       $display("------------------------- VALUES AFTER SET RESET() ----------------------------");

       reg_block.Reg4_reg_inst.set_reset('hff);
       reg_block.Reg4_reg_inst.reset();

      `uvm_info("REG4_SEQ RESET VALUE [get_reset()]" , $sformatf("Rst_value = %0h",reg_block.Reg4_reg_inst.get_reset()),UVM_LOW);
       Ref_data = reg_block.Reg4_reg_inst.get();
       `uvm_info("REG4_SEQ AFTER (RESET) DESIRED" , $sformatf("DESIRED VALUE = %0h",Ref_data),UVM_LOW);
       Ref_data = reg_block.Reg4_reg_inst.get_mirrored_value();
       `uvm_info("REG4_SEQ AFTER (RESET) DESIRED" , $sformatf("MIRRORED VALUE = %0h",Ref_data),UVM_LOW);

        $display("-------------------------------------------------------------------------");
  



    endtask

endclass

////////////////////////////////////////

class reg4rd_seq extends uvm_sequence;
  `uvm_object_utils(reg4rd_seq)

   Reg_Block reg_block;

  function new(string name = "reg4rd_seq");
        super.new(name);
  endfunction

    task body();

      uvm_status_e  status;
      bit [31:0] rdata;

      for(int i = 0 ; i < 10000; i++) begin
         reg_block.Reg4_reg_inst.read(status,rdata);
      end

    endtask

endclass


//////////////////////////////////////

class reg1_backdoor_seq extends uvm_sequence;
  `uvm_object_utils(reg1_backdoor_seq)

   Reg_Block reg_block;
   uvm_reg_data_t Ref_data;


  function new(string name = "reg1_backdoor_seq");
        super.new(name);
  endfunction

    task body();

      uvm_status_e  status;
      bit [31:0] wdata , rdata;

      for(int i = 0 ; i < 10000 ; i++) begin
         wdata = $random();
         reg_block.Reg1_reg_inst.write(status,wdata,UVM_BACKDOOR);
         reg_block.Reg1_reg_inst.read(status,rdata,UVM_BACKDOOR);
         
         `uvm_info("(BACKDOOR) rdata" , $sformatf("RDATA = %0h",rdata),UVM_LOW);
         Ref_data = reg_block.Reg1_reg_inst.get();
         `uvm_info("(BACKDOOR) DESIRED" , $sformatf("DESIRED VALUE = %0h",Ref_data),UVM_LOW);
         Ref_data = reg_block.Reg1_reg_inst.get_mirrored_value();
         `uvm_info("(BACKDOOR) DESIRED" , $sformatf("MIRRORED VALUE = %0h",Ref_data),UVM_LOW);
      end

       $display("------------------------- PEEK() & POKE() ----------------------------");


         reg_block.Reg1_reg_inst.poke(status,32'hBCBCBCBC);
         reg_block.Reg1_reg_inst.peek(status,rdata);
         

         `uvm_info("(BACKDOOR) rdata" , $sformatf("RDATA = %h",rdata),UVM_LOW);
         Ref_data = reg_block.Reg1_reg_inst.get();
         `uvm_info("(BACKDOOR) DESIRED" , $sformatf("DESIRED VALUE = %0h",Ref_data),UVM_LOW);
         Ref_data = reg_block.Reg1_reg_inst.get_mirrored_value();
         `uvm_info("(BACKDOOR) DESIRED" , $sformatf("MIRRORED VALUE = %0h",Ref_data),UVM_LOW);      

    endtask

endclass

endpackage
