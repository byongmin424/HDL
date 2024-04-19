`timescale 1ns/1ns

module tb_add_sub ();

reg [3:0] r_a;
reg [3:0] r_b;
reg r_s;

initial begin
    r_a = 0;
    r_b = 0;
    r_s = 0;

    repeat(32)
    begin
        #10;
        r_a = $urandom;
        r_b = $urandom;
        r_s = $urandom;        
    end
end

add_sub         u_test
(
    .i_a        (r_a),
    .i_b        (r_b),
    .i_s        (r_s),
    .o_sum      (w_sum),
    .o_cout     (w_cout)
);

wire [3:0] w_sum;
wire w_cout;

initial begin
    $dumpfile("tb_add_sub.vcd");
    $dumpvars(1);
end

endmodule