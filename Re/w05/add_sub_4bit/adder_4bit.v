module adder_4bit (
    input   wire  [3:0]     i_a,
    input   wire  [3:0]     i_b,
    input   wire            i_cin,
    output  wire  [3:0]     o_sum,
    output  wire            o_cout
);


fa      u_fa_0
(
    .i_a            (i_a[0]),
    .i_b            (i_b[0]),
    .i_cin          (i_cin),
    .o_sum          (o_sum[0]),
    .o_cout         (w_carry_0)
);

wire w_carry_0;

fa      u_fa_1
(
    .i_a            (i_a[1]),
    .i_b            (i_b[1]),
    .i_cin          (w_carry_0),
    .o_sum          (o_sum[1]),
    .o_cout         (w_carry_1)
);

wire w_carry_1;

fa      u_fa_2
(
    .i_a            (i_a[2]),
    .i_b            (i_b[2]),
    .i_cin          (w_carry_1),
    .o_sum          (o_sum[2]),
    .o_cout         (w_carry_2)
);

wire w_carry_2;

fa      u_fa_3
(
    .i_a            (i_a[3]),
    .i_b            (i_b[3]),
    .i_cin          (w_carry_2),
    .o_sum          (o_sum[3]),
    .o_cout         (o_cout)
);

endmodule