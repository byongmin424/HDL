`timescale 1ns/1ns

module tb_comparator_2bit ();

reg [1:0] test_sig;

initial begin
    test_sig = 0;
    
    repeat(16)
    begin
        #10;
        test_sig = test_sig + 1;
    end
end

wire w_equal, w_not_equal, w_great_a, w_great_b;

comparator_2bit     u_test
(
    .i_a            (test_sig[0]),
    .i_b            (test_sig[1]),
    .o_equal        (w_equal),
    .o_not_equal    (w_not_equal),
    .o_great_a      (w_great_a),
    .o_great_b      (w_great_b)
);

initial begin
    $dumpfile("tb_comp.vcd");
    $dumpvars(1);
end

endmodule