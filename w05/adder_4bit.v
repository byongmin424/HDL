module adder_4bit
(
    input   wire    [3:0]   i_a,
    input   wire    [3:0]   i_b,
    input   wire            i_cin,
    output  wire    [3:0]   o_sum,
    output  wire            o_cout
);

wire    w_cin_0, w_cin_1, w_cin_2;

full_adder_2ha  u_fa0
(
    .i_a        (i_a[0]     ),
    .i_b        (i_b[0]     ),
    .i_cin      (i_cin      ),
    .o_sum      (o_sum[0]   ),
    .o_cout     (w_cin_0    )
);

full_adder_2ha  u_fa1
(
    .i_a        (i_a[1]     ),
    .i_b        (i_b[1]     ),
    .i_cin      (w_cin_0    ),
    .o_sum      (o_sum[1]   ),
    .o_cout     (w_cin_1    )
);

full_adder_2ha  u_fa2
(
    .i_a        (i_a[2]     ),
    .i_b        (i_b[2]     ),
    .i_cin      (w_cin_1    ),
    .o_sum      (o_sum[2]   ),
    .o_cout     (w_cin_2    )
);

full_adder_2ha  u_fa3
(
    .i_a        (i_a[3]     ),
    .i_b        (i_b[3]     ),
    .i_cin      (w_cin_2    ),
    .o_sum      (o_sum[3]   ),
    .o_cout     (o_cout     )
);


endmodule