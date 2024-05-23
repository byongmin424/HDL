module counter_4bit (
    input   wire            i_clk,
    input   wire            i_rst_n,
    input   wire            i_enable,
    output  reg     [3:0]   o_count
);

always @(posedge i_clk or negedge i_rst_n) begin
    if (~i_rst_n)
        o_count <= 0;
    else begin
        if (i_enable)
            o_count <= o_count + 1;
    end
end

endmodule