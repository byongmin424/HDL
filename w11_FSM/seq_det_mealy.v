module seq_det_mealy (
    input   wire        i_rst_n,
    input   wire        i_clk,
    input   wire        i_enable,
    
    input   wire        i_seq,
    output  wire        o_detect
);


reg [1:0] state, next_state;
// 조합회로 always_다음상태를 결정하는 부분
always @(*) begin
    case (state)
        0 : begin
            if (i_seq == 0) next_state = 0;
            else            next_state = 1;
        end
        1 : begin
            if (i_seq == 0) next_state = 2;
            else            next_state = 1;
        end
        2 : begin
            if (i_seq == 0) next_state = 0;
            else            next_state = 1;
        end
        default :           next_state = 0;
    endcase
end

// 순차회로 always_ 다음상태가 현재상태로 업데이트 되는 부분
always @(posedge i_clk or negedge i_rst_n) begin
    if (~i_rst_n)
        state <= 0;
    else begin
        if (i_enable)
            state <= next_state;
    end
end

// 출력이 결정 되는 부분
assign o_detect = (state == 2) & (i_seq == 1);

endmodule