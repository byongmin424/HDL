`timescale 1ns/10ps

module half_adder_tb ();

reg test_sig1;
reg test_sig2;

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

    #10;
end

half_adder  u_test_half_adder
(
    .i_a        (test_sig1  ),
    .i_b        (test_sig2  ),
    .o_sum      (o_sum      ),
    .o_carry    (o_carry    )
);
    
endmodule
