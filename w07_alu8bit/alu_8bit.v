module alu_8bit (
    input   wire    [7:0]   i_a,
    input   wire    [7:0]   i_b,
    input   wire    [2:0]   i_op,
    output  reg     [7:0]   o_result,
    output  wire    [7:0]   o_flag
);

always @(*) begin
    case (i_op)
        3'b000 : o_result = i_a + i_b;
        3'b001 : o_result = i_a - i_b;
        3'b010 : o_result = i_b - i_a;
        3'b011 : o_result = i_a & i_b;
        3'b100 : o_result = i_a | i_b;
        3'b101 : o_result = i_a ^ i_b;
        3'b110 : o_result = ~i_a;
        3'b111 : o_result = 8'b0;
    endcase
end

// overflow 조건
reg r_overflow;
always @(*)
begin
    if (i_op = 3'b000)
    begin
        if ((i_a[7] == 0) & (i_b[7] == 0) & (o_result[7] == 1))
            r_overflow = 1'b1;
        else if ((i_a[7] = 1) & (i_b[7] == 1) & (o_result[7] == 0))
            r_overflow = 1'b1;
        else
            r_overflow = 1'b0;
    end

    else if (i_op == 3'b001)
    begin
        if (~i_a[7] & i_b[7] & o_result[7])
            r_overflow = 1'b1;
        else if (i_a[7] & ~i_b[7] & ~o_result[7])
            r_overflow = 1'b1;
        else
            r_overflow = 1'b0;
    end

    else if (i_op == 3'b010)
    begin
        if (~i_b[7] & i_a[7] & o_result[7])
            r_overflow = 1'b1;
        else if (i_b[7] & ~i_a[7] & ~o_result[7])
            r_overflow = 1'b1;
        else
            r_overflow = 1'b0;
    end
    
    else
        r_overflow = 1'b0;
end

// 비교기
wire    w_zero;
wire    w_equal;
wire    w_not_eq;
wire    w_greater_a;
wire    w_greater_b;

assign  w_zero = (i_op != 3'b111) ? (o_result == 0) : 1'b0;
assign  w_equal = (i_op == 3'b111) ? (i_a == i_b) : 1'b0;
assign  w_not_eq = (i_op == 3'b111) ? (i_a != i_b) : 1'b0;
assign  w_greater_a = (i_op == 3'b111) ? (i_a > i_b) : 1'b0;
assign  w_greater_b = (i_op == 3'b111) ? (i_a < i_b) : 1'b0;

assign o_flag = {w_greater_b, w_greater_a, w_not_eq, w_equal, 2'b0, w_zero, r_overflow};
    
endmodule