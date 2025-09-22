class test extends uvm_test;
`uvm_component_utils("test")

env envir;
wr_generator wr_seq;
//rd_seq

function new(string name = "test",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
envir=env::type_id::create("envir",this);
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
super.end_of_elaboration_phase(phase);
uvm_top.print_topology();
endfunction

virtual task run_phase(uvm_phase phase);
super.run_phase(phase);

phase.raise_objection(this);
wr_seq=wr_generator::type_id::create("wr_seq",this);
//rd_seq
fork begin
wr_seq.start(envir.wr_a.seqr);
end
begin repeat(2) #20
//rd_seq
end
join

phase.drop_objection(this);
endtask


endclass