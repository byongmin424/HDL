module fa (
    input   wire        i_a,
    input   wire        i_b,
    input   wire        i_cin,
    output  wire        o_sum,
    output  wire        o_cout
);

/*
    0 0 0   0 0
    0 0 1   1 0
    0 1 0   1 0
    0 1 1   0 1
    1 0 0   1 0
    1 0 1   0 1
    1 1 0   0 1
    1 1 1   1 1
*/
wire w_m;
assign w_m = i_a ^ i_b; // 
assign o_sum = w_m ^ i_cin;
assign o_cout = (i_cin & w_m) | (i_a & i_b);

endmodule