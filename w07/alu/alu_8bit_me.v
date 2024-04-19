module alu_8bit_me (
    input   wire    [7:0]       i_a,
    input   wire    [7:0]       i_b,
    input   wire    [2:0]       i_op,
    output  reg     [7:0]       o_result,
    output  wire    [7:0]       o_flag
);
always @(*) begin
    case (i_op)
        0 : o_result = i_a + i_b;
        1 : o_result = i_a - i_b;
        2 : o_result = i_b - i_a;
        3 : o_result = i_a & i_b;
        4 : o_result = i_a | i_b;
        5 : o_result = i_a ^ i_b;
        6 : o_result = ~i_a;
        7 : o_result = 0;
    endcase
end

reg r_overflow;
always @(*) begin
    if (i_op == 0) begin // addition
        if (~i_a[7] & ~i_b[7] & o_result[7])
            r_overflow = 1;
        else if(i_a[7] & i_b[7] & ~o_result[7])
            r_overflow = 1;
        else
            r_overflow = 0;
    end
    else if (i_op == 1) begin // subtraction 1 : (a - b)
        if (~i_a[7] & i_b[7] & o_result[7])
            r_overflow = 1;
        else if(i_a[7] & ~i_b[7] & ~o_result[7])
            r_overflow = 1;
        else
            r_overflow = 0;
    end
    else if (i_op == 2) begin // subtraction 2 : (b - a)
        if (~i_b[7] & i_a[7] & o_result[7])
            r_overflow = 1;
        else if(i_b[7] & ~i_a[7] & ~o_result[7])
            r_overflow = 1;
        else
            r_overflow = 0;
    end
    else
        r_overflow = 0;
end


// 비교기
wire    w_zero;
wire    w_equal;
wire    w_not_equal;
wire    w_greater_a;
wire    w_greater_b; 

assign  w_zero = (i_op != 7) ? (o_result == 0) : 0; 
assign  w_equal = (i_op == 7) ? (i_a == i_b) : 0;
assign  w_not_equal = (i_op == 7) ? (i_a != i_b) : 0;
assign  w_greater_a = (i_op == 7) ? (i_a > i_b) : 0;
assign  w_greater_b = (i_op == 7) ? (i_a < i_b) : 0; 

assign  o_flag[0] = r_overflow;
assign  o_flag[1] = w_zero;
assign  o_flag[3:2] = 0;
assign  o_flag[4] = w_equal;
assign  o_flag[5] = w_not_equal;
assign  o_flag[6] = w_greater_a;
assign  o_flag[7] = w_greater_b; 
// assign  o_flag = {w_greater_b, w_greater_a, w_not_equal, w_equal, 2'b0, w_zero, r_overflow};

endmodule