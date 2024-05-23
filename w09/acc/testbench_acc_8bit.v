`timescale 1ns/1ns

module  testbench_acc_8bit();

initial begin
    $dumpfile("sim_acc.vcd");
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


// enable, init test signal
reg    r_enable;
reg    r_init;

initial begin
    r_enable = 0;
    r_init   = 0;
    @(posedge r_rst_n); // rst가 1이 (5번) 뜨는 순간 
    repeat(5) @(posedge r_clk); // 1이 5번뜨면 clk가 1이 뜨는 순간
    r_init = 1; // init = 1
    @(posedge r_clk); // clk가 1이 뜨는 순간(1 사이클)
    r_init = 0; // init = 0
    @(posedge r_clk); // clk가 1이 뜨는 순간(1 사이클)
    r_enable = 1; // enable = 1
    repeat(10) @(posedge r_clk); // 10 사이클 돌면
    r_enable = 0; // enable = 0
end

// in test signal
reg    [7:0]    r_in;

always  @(posedge r_clk)
begin
    if  (~r_rst_n)
      r_in = 8'd0;
    else
    begin
      if  (r_enable)
        r_in = r_in + 8'd1; 
    end
end

wire [15:0] w_acc;
acc_8bit        u_test_acc
(
    .i_clk      (r_clk      ),
    .i_rst_n    (r_rst_n    ),
    .i_enable   (r_enable   ),
    .i_init     (r_init     ),
    .i_in       (r_in       ),
    .o_acc      (w_acc      )
);

endmodule