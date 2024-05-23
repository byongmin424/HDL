`timescale 1ns/1ns

module  testbench_add_4_nums();

initial begin
    $dumpfile("sim_add.vcd");
    $dumpvars(1);
end

// clock test signal
reg    r_clk;
initial begin
    r_clk = 1'b0;
    repeat(40)
        #10 r_clk = ~r_clk;
end

// Reset(negedge) test signal
reg    r_rst_n;
initial begin
    r_rst_n = 1'b0;
    #40 r_rst_n = 1'b1;
end


reg    r_enable;
initial begin
    r_enable = 0;
    forever begin
        repeat(5) @(posedge r_clk);
        r_enable = 1;
        repeat(10) @(posedge r_clk);
        r_enable = 0;
    end
end

// in test signal
reg    [7:0]    r_a, r_b, r_c, r_d;
always  @(posedge r_clk) begin
    if  (~r_rst_n) begin
      r_a = 0;
      r_b = 0;
      r_c = 0;
      r_d = 0;
    end
    else begin
        if  (r_enable) begin
            r_a = $urandom;
            r_b = $urandom;
            r_c = $urandom;
            r_d = $urandom;        
        end  
    end
end

wire [9:0] w_sum;

add_4_nums      u_test_acc
(
    .i_rst_n    (r_rst_n   ),
    .i_clk      (r_clk     ),
    .i_enable   (r_enable  ),
    .i_a        (r_a       ),
    .i_b        (r_b       ),
    .i_c        (r_c       ),
    .i_d        (r_d       ),
    .o_sum      (w_sum     )
);

endmodule