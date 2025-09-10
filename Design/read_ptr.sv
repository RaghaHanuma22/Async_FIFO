module read_ptr_handler #(parameter ptr_width = 6)(
    input logic rclk,
    input logic r_en,
    input logic rrst_n,
    input logic [ptr_width-1 :0] g_wptr_sync,
    output logic [ptr_width-1 :0] g_rptr,
    output logic [ptr_width-1 :0] b_rptr,
    output logic empty
);

logic [ptr_width-1 :0] b_rptr_next;
logic [ptr_width-1 :0] g_rptr_next;
logic rempty;

assign b_rptr_next = (b_rptr == 6'b110110)? 6'b001001 : b_rptr + ((r_en & ~empty));
assign g_rptr_next = (b_rptr_next) ^ (b_rptr_next>>1);
assign rempty = (g_wptr_sync == g_rptr); //g_rptr_next - modified


always @(posedge rclk or negedge rrst_n) begin
    if (!rrst_n) begin
        b_rptr <= 6'b001001;
        g_rptr <= 6'b001101;
        empty <= 1;
    end 
    else begin
        //b_rptr <= b_rptr + 1;
        //g_rptr <= (b_rptr) ^ (b_rptr>>1);
        b_rptr <= b_rptr_next;
        g_rptr <= g_rptr_next;
        empty <= rempty;
    end
end

endmodule