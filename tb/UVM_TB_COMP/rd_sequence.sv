`include "uvm_macros.svh"
import uvm_pkg::*;
`include "rd_seq_item.sv"

class rd_seq extends uvm_sequence#(rd_transaction #(8));
    `uvm_object_utils(rd_seq)

    int num = 45;

    function new (string name = "rd_seq");
        super.new(name);
    endfunction

    virtual task body();
        rd_transaction #(8) tx;
        repeat(num) begin
            tx = rd_transaction#(8)::type_id::create("tx",this);
            start_item(tx);
            if(!tx.randomize()) `uvm_error("rd_seq","Transaction not randomized");
            finish_item(tx);
        end 
    endtask
    
endclass