module ha (
    input   wire        i_a,
    input   wire        i_b,
    output  wire        o_sum,
    output  wire        o_carry
);

/*
a b s c
0 0 0 0
0 1 1 0
1 0 1 0
1 1 0 1
*/
assign o_sum = i_a ^ i_b;
assign o_carry = i_a & i_b;

endmodule