package my_test_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import my_env_pkg::*;
import reg_seq_pkg::*;


`define create(type , inst_name)  type::type_id::create(inst_name,this);

class my_test extends uvm_test;
	`uvm_component_utils(my_test)


my_env  env;
ctrlw_seq cwr;
ctrlrd_seq crd; 
reg1wr_seq R1_wr_seq;
reg1rd_seq R1_rd_seq;
reg2wr_seq R2_wr_seq;
reg2rd_seq R2_rd_seq;
reg3wr_seq R3_wr_seq;
reg3rd_seq R3_rd_seq;
reg4wr_seq R4_wr_seq;
reg4rd_seq R4_rd_seq;
reg1_backdoor_seq Reg1_backdoor_seq;

	function new (string name = "my_test" , uvm_component parent = null);
		super.new(name , parent);
	endfunction


    function void build_phase(uvm_phase phase);
    	super.build_phase(phase);

      env = `create(my_env , "env");

      cwr = ctrlw_seq::type_id::create("cwr");
      crd = ctrlrd_seq::type_id::create("crd");

      R1_wr_seq = reg1wr_seq::type_id::create("R1_wr_seq");
      R1_rd_seq = reg1rd_seq::type_id::create("R1_rd_seq");

      R2_wr_seq = reg2wr_seq::type_id::create("R2_wr_seq");
      R2_rd_seq = reg2rd_seq::type_id::create("R2_rd_seq");      


      R3_wr_seq = reg3wr_seq::type_id::create("R3_wr_seq");
      R3_rd_seq = reg3rd_seq::type_id::create("R3_rd_seq"); 


      R4_wr_seq = reg4wr_seq::type_id::create("R4_wr_seq");
      R4_rd_seq = reg4rd_seq::type_id::create("R4_rd_seq");             

      Reg1_backdoor_seq = reg1_backdoor_seq::type_id::create("Reg1_backdoor_seq");

      `uvm_info("MY_TEST" , "TEST BUILT" , UVM_LOW);
    endfunction




  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction





    task run_phase(uvm_phase phase);
    	//super.run_phase(phase);
        
        phase.raise_objection(this);
 		 `uvm_info("RUN TEST" , "TEST HERE" , UVM_LOW);
 		 
$display("======================= CTRL REG SEQ =======================");

         cwr.reg_block = env.reg_block;
         cwr.start(env.agent.seqr);
         
         crd.reg_block =  env.reg_block;
         crd.start(env.agent.seqr);

$display("======================= REG1 REG SEQ =======================");

         R1_wr_seq.reg_block = env.reg_block;
         R1_wr_seq.start(env.agent.seqr);

         R1_rd_seq.reg_block = env.reg_block;
         R1_rd_seq.start(env.agent.seqr);

$display("======================= REG2 REG SEQ =======================");

         R2_wr_seq.reg_block = env.reg_block;
         R2_wr_seq.start(env.agent.seqr);         

         R2_rd_seq.reg_block = env.reg_block;
         R2_rd_seq.start(env.agent.seqr);   

$display("======================= REG3 REG SEQ =======================");

         R3_wr_seq.reg_block = env.reg_block;
         R3_wr_seq.start(env.agent.seqr);         

         R3_rd_seq.reg_block = env.reg_block;
         R3_rd_seq.start(env.agent.seqr);

$display("======================= REG4 REG SEQ =======================");

         R4_wr_seq.reg_block = env.reg_block;
         R4_wr_seq.start(env.agent.seqr);         

         R4_rd_seq.reg_block = env.reg_block;
         R4_rd_seq.start(env.agent.seqr);

$display("======================= BACKDOOR REG1 SEQ ===================");

        Reg1_backdoor_seq.reg_block = env.reg_block;
        Reg1_backdoor_seq.start(env.agent.seqr);

         phase.drop_objection(this);
         phase.phase_done.set_drain_time(this, 200);


    endtask

endclass

endpackage
