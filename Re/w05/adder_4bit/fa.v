module fa (
    input   wire    i_a,
    input   wire    i_b,
    input   wire    i_cin,
    output  wire    o_sum,
    output  wire    o_cout
);

// module instatiaion
ha      ha_1
(
    .i_a            (i_a        ),
    .i_b            (i_b        ),
    .o_sum          (w_sum      ),
    .o_carry        (w_carry_1  )
);

wire w_sum;

ha      ha_2
(
    .i_a            (w_sum      ),
    .i_b            (i_cin      ),
    .o_sum          (o_sum      ),
    .o_carry        (w_carry_2  )
);

wire w_carry_1, w_carry_2;

assign o_cout = w_carry_1 | w_carry_2;
    
endmodule