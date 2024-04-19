`timescale 1ns/1ns

module first_tb();

reg [1:0] test_sig;


initial begin
    test_sig = 0;

    repeat(8) begin
        #10;
        test_sig = test_sig + 1;
    end
end

initial begin
    $dumpfile("first_tb.vcd");
    $dumpvars(1);
end

first_module      u_test_sig
(
    .first_in         (test_sig),
    .first_out1       (first_out1),
    .first_out2       (first_out2),
    .first_out3       (first_out3)
);

endmodule