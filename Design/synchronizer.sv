//module for synchronizer

module sync(input logic rst, clk, din, output logic dout);
logic q1;
always_ff @(posedge clk or negedge rst) begin
    if(!rst) begin
        dout<=0;
    end
    else begin
        q1<=din;
        dout<=q1;
    end
end
endmodule
 