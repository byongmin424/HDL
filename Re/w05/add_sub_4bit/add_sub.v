module add_sub (
    input   wire  [3:0]     i_a,
    input   wire  [3:0]     i_b,
    input                   i_s,
    output  wire  [3:0]     o_sum,
    output  wire            o_cout
);

wire [3:0] w_b;
assign w_b[0] = i_b[0] ^ i_s;
assign w_b[1] = i_b[1] ^ i_s;
assign w_b[2] = i_b[2] ^ i_s;
assign w_b[3] = i_b[3] ^ i_s;

adder_4bit          u_adder
(
    .i_a        (i_a),
    .i_b        (w_b),
    .i_cin      (i_s),
    .o_sum      (o_sum),
    .o_cout     (o_cout)
);

endmodule