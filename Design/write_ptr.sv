//Module for write pointer

module w_ptr(input logic wclk, wrst_n, input logic[5:0] g_rptr_sync, output logic[5:0] b_wptr, g_wptr, output logic full);
logic[5:0] b_wptr_next = 10;
logic[5:0] g_wptr_next;
logic[5:0] b_rptr_sync;
logic[5:0] b_wptr_sync;
//logic[5:0] b_rptr;

//logic wfull;

always_ff @(posedge wclk or negedge wrst_n) begin
    if(!wrst_n) begin
        //full<=0;
        b_wptr<=6'b001010;
        //g_wptr<=6'b001111;
    end
    else if(!full) begin
        if(b_wptr==53) begin
            b_wptr_next=10;
        end
        else begin
            b_wptr_next=b_wptr+1;
            b_wptr=b_wptr_next;
        end
    end
end

assign b_rptr_sync[5] = g_rptr_sync[5];
assign b_rptr_sync[4] = g_rptr_sync[4]^b_rptr_sync[5];
assign b_rptr_sync[3] = g_rptr_sync[3]^b_rptr_sync[4];
assign b_rptr_sync[2] = g_rptr_sync[2]^b_rptr_sync[3];
assign b_rptr_sync[1] = g_rptr_sync[1]^b_rptr_sync[2];
assign b_rptr_sync[0] = g_rptr_sync[0]^b_rptr_sync[1];

assign g_wptr[5] = b_wptr_sync[5];
assign g_wptr[4] = b_wptr_sync[5]^b_wptr_sync[4];
assign g_wptr[3] = b_wptr_sync[4]^b_wptr_sync[3];
assign g_wptr[2] = b_wptr_sync[3]^b_wptr_sync[2];
assign g_wptr[1] = b_wptr_sync[2]^b_wptr_sync[1];
assign g_wptr[0] = b_wptr_sync[1]^b_wptr_sync[0];

assign full = (b_wptr[4:0] == b_rptr_sync[4:0] && b_wptr[5] != b_rptr_sync[5]);
endmodule



