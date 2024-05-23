`timescale 1ns/1ns

module  tb_fsm();

initial begin
    $dumpfile("sim_add.vcd");
    $dumpvars(1);
end

// clock test signal
reg    r_clk;
initial begin
    r_clk = 1'b0;
    repeat(500) begin
        #10 r_clk = ~r_clk;
    end
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
        repeat(7) @(posedge r_clk);
        r_enable = 1;
        repeat(16) @(posedge r_clk);
        r_enable = 0;
    end
end

// // in test signal
// reg     r_seq;
// initial begin
//     r_seq = 0;
//     forever begin
//         repeat(9) @(posedge r_clk);
//         r_seq = 1;
//         repeat(2) @(posedge r_clk);
//         r_seq = 0;
//         repeat(1) @(posedge r_clk);
//         r_seq = 1;
//         repeat(2) @(posedge r_clk);
//         r_seq = 0;
//         repeat(2) @(posedge r_clk);
//         r_seq = 1;
//         repeat(1) @(posedge r_clk);
//         r_seq = 0;
//         repeat(1) @(posedge r_clk);
//         r_seq = 1;
//         repeat(1) @(posedge r_clk);
//         r_seq = 0;
//         repeat(1) @(posedge r_clk);
//         r_seq = 1;
//         repeat(1) @(posedge r_clk);
//         r_seq = 0;
//     end
// end

// wire w_seg;
// assign w_seq = r_seq;

// 위에와 같은 말
reg [15:0] r_seq;
always @(posedge r_clk or negedge r_rst_n) begin
    if (~r_rst_n)
        r_seq <= 16'b0011011001010100;
    else begin
        if (r_enable) begin
            r_seq[15:1] <= r_seq[14:0];
            r_seq[0] <= r_seq[15];
        end
    end
end

wire w_seq;
assign w_seq = r_seq[15];
wire w_det_moore;

seq_det_moore   u_test_acc
(
    .i_rst_n    (r_rst_n        ),
    .i_clk      (r_clk          ),2
    .i_enable   (r_enable       ),
    .i_seq      (w_seq          ),
    .o_detect   (w_det_moore    )
);

endmodule