`timescale 1ns/1ns

module ha_tb();

reg [1:0]test_sig;

initial
begin
    $dumpfile("ha_tb.vcd");
    $dumpvars(1);
end

initial begin
    test_sig = 0;
    
    repeat(16)
    begin
        #10;
        test_sig = test_sig + 1;
    end
end

ha      u_test
(
    .i_a        (test_sig[0]),
    .i_b        (test_sig[1]),
    .o_sum      (o_sum),
    .o_carry    (o_carry)
);

endmodule