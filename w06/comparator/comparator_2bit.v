module comparator_2bit (
    input    wire            i_a,
    input    wire            i_b,
    output   wire            o_equal,
    output   wire            o_not_equal,
    output   wire            o_great_a,
    output   wire            o_great_b
);

assign  o_equal      = (i_a == i_b) ? 1'b1 : 1'b0;
assign  o_not_equal  = (i_a != i_b) ? 1'b1 : 1'b0;
assign  o_great_a    = (i_a > i_b)  ? 1'b1 : 1'b0;
assign  o_great_b    = (i_a < i_b)  ? 1'b1 : 1'b0;

endmodule