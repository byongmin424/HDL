`timescale 1ns / 10ps

module first_tb ();

reg  test_sig1;
reg  test_sig2;

initial begin
    $dumpfile("first_tb.vcd");
    $dumpvars(1);
end

initial begin
    // forever begin //이렇게 하면 반복적으로 test_sig신호가 나온다.
    test_sig1 = 0;
    test_sig2 = 0;

    #10;
    test_sig1 = 0;
    test_sig2 = 1;

    #10;
    test_sig1 = 1;
    test_sig2 = 0;

    #10;
    test_sig1 = 1;
    test_sig2 = 1;

    #10;
    // end 
end

first_module    u_test_module
(
    .first_in1      (test_sig1  ),
    .first_in2      (test_sig2  ),
    .first_out1     (first_out1 )
);

endmodule