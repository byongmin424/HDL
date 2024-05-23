module tb();

reg [2:0] test_sig;

initial
begin
    test_sig = 0;
    repeat (20) begin
        #10 test_sig = test_sig + 1;
    end
end

initial
begin
    $dumpfile("tb.vcd");
    $dumpvars(1);
end

wire  w_sum;
wire  w_cout;

full_adder_2ha    u_test_full
(
    .i_a        (test_sig[2]  ),
    .i_b        (test_sig[1]  ),
    .i_cin      (test_sig[0]  ),
    .o_sum      (w_sum          ),
    .o_cout     (w_cout         )
);

endmodule