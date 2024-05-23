`timescale 1ns/1ns

module testbench_counter_4bit ();
    
reg r_clk;

initial begin
    r_clk  = 0;
    repeat(180) begin
        #10 r_clk = ~r_clk;
    end
end

reg r_rst_n;
initial begin
    r_rst_n = 1;
    #55 r_rst_n = 0;
    #115 r_rst_n = 1;
end

reg r_enable;
initial begin
    r_enable = 0;
    @(posedge r_rst_n);
    repeat(5) @(posedge r_clk);
    r_enable = 1;
    repeat(2) @(posedge r_clk);
    r_enable = 0;
end

wire [3:0]  w_count;
counter_4bit      u_counter_4bit
(
    .i_clk        (r_clk      ),
    .i_rst_n      (r_rst_n    ),
    .i_enable     (r_enable   ),
    .o_count      (w_count    )
);

initial begin
    $dumpfile("simul_counter.vcd");
    $dumpvars(1);
end

endmodule