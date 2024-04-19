`timescale 1ns / 10ps

module first_tb ();
    
reg  test_sig1;
reg  test_sig2;

initial begin
    $dumpfile("first_tb.vcd");
    $dumpvars(1);
end

// test 신호 만들기
initial begin
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

    #10; // 이렇게 해야 다음 신호 차례에 신호가 쭉 이어진다.
end

// instantiation & port mapping
first_module    u_test_module
(
    .first_in1      (test_sig1      ),
    .first_in2      (test_sig2      ),
    .first_out1     (first_out1     ),
    .first_out2     (first_out2     ),
    .first_out3     (first_out3     ),
);

endmodule