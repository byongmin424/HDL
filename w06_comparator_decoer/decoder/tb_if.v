`timescale 1ns/1ns

module tb_if ();

reg [1:0] test_sig;

initial begin
    test_sig = 0;

    repeat(16) begin
        #10;
        test_sig = test_sig + 1;
    end
end

wire [3:0] w_y;

decoder_2x4_if  u_if_decoder
(
    .i_a(test_sig),
    .o_y(w_y)  
);

initial begin
    $dumpfile("tb_if.vcd");
    $dumpvars(1);
end
endmodule