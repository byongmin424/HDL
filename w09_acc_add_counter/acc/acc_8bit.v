module acc_8bit (
    input   wire            i_clk,
    input   wire            i_rst_n,
    input   wire            i_enable,
    input   wire            i_init,
    input   wire    [7:0]   i_in,
    output  reg     [15:0]  o_acc
);

always @(posedge i_clk or negedge i_rst_n) begin
    if (~i_rst_n)
        o_acc <= 0;
    else begin
        if (i_init)
            o_acc <= 0;
        else if (i_enable)
            o_acc <= o_acc + i_in;
    end
end

endmodule