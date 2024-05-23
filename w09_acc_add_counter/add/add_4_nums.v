module add_4_nums (
    input   wire            i_rst_n,
    input   wire            i_clk,
    input   wire            i_enable,
    input   wire    [7:0]   i_a,
    input   wire    [7:0]   i_b,
    input   wire    [7:0]   i_c,
    input   wire    [7:0]   i_d,
    output  reg     [9:0]   o_sum
);
    
reg [9:0] r_ab, r_cd;
always @(posedge i_clk or negedge i_rst_n) begin
    if(~i_rst_n)
        r_ab <= 0;
    else begin
        if(i_enable)
            r_ab <= i_a + i_b;
    end
end

always @(posedge i_clk or negedge i_rst_n) begin
    if(~i_rst_n)
        r_cd <= 0;
    else begin
        if(i_enable)
            r_cd <= i_c + i_d;
    end
end

///////////////////////////////////////////////

always @(posedge i_clk or negedge i_rst_n) begin
    if(~i_rst_n)
        o_sum <= 0;
    else begin
        if(i_enable)
            o_sum <= r_ab + r_cd;
    end
end

endmodule