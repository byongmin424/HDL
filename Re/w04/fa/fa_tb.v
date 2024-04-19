`timescale 1ns/1ns

module fa_tb();

reg [2:0] test_sig;

// 00 01 10 11 test_signal
initial begin
    test_sig = 0;

    repeat (16) begin
        #10 test_sig = test_sig + 1;
    end
end

fa      u_test_fa
(
    .i_a    (test_sig[0]    ),
    .i_b    (test_sig[1]    ),
    .i_cin  (test_sig[2]    ),
    .o_sum  (o_sum          ),
    .o_cout (o_cout         )
);

initial begin
    $dumpfile("fa_tb.vcd");
    $dumpvars(1);
end

endmodule