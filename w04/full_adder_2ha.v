module full_adder_2ha (
    input   wire        i_a,
    input   wire        i_b,
    input   wire        i_cin,
    output  wire        o_sum,
    output  wire        o_cout
);

wire  w_sum;
wire  w_carry_1, w_carry_2;

half_adder      u_ha_1
(
    .i_a        (i_a        ),
    .i_b        (i_b        ),
    .o_sum      (w_sum      ),
    .o_carry    (w_carry_1  )
);

half_adder      u_ha_2
(
    .i_a        (w_sum     ),
    .i_b        (i_cin      ),
    .o_sum      (o_sum      ),
    .o_carry    (w_carry_2  )
);

wire  w_cout = w_carry_1 | w_carry_2;
assign  o_cout = w_cout;

endmodule