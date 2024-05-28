module digital_modulator (
    input   wire            i_rst_n,
    input   wire            i_clk,
    input   wire            i_en,
    input   wire            i_data_vld,
    input   wire            i_data,
    input   wire    [1:0]   i_mod,
    output  wire            o_out_vld, // 데이터 유효성을 판단하는 신호
    output  reg     [11:0]  o_i,
    output  reg     [11:0]  o_q
);

// i_en이 High일때 0~7까지 반복 카운트
reg     [2:0]   r_cnt;
always @(posedge i_clk or negedge i_rst_n) begin
    if (~i_rst_n)
        r_cnt <= 0;
    else begin
        if (i_en)
            r_cnt <= r_cnt + 1; 
    end
end

// i_data_vld가 High일때 i_data를 순서대로 저장
reg     [5:0]   r_shift_reg; // why 6bit? -> 64항(6비트)고려
always @(posedge i_clk or negedge i_rst_n) begin
    if (~i_rst_n)
        r_shift_reg <= 0;
    else begin
        if (i_data_vld) begin
            r_shift_reg[5:1] <= r_shift_reg[4:0];
            r_shift_reg[0] <= i_data;
        end
    end
end

// 카운터가 7일때ㅡ r_shift_reg를 보고 심볼을 결정.
// 상위 비트들로 o_i를 결정.
always @(posedge i_clk or negedge i_rst_n) begin
    if (~i_rst_n) begin
        o_i <= 0;
    end
    else begin
        if (r_cnt == 7) begin
            if (i_mod == 0) begin // BPSK
                case (r_shift_reg[0])
                   1'b0 : o_i <= -256;
                   1'b1 : o_i <= 256;
                endcase
            end
            else if (i_mod == 1) begin // QPSK
                case (r_shift_reg[1])
                   1'b0 : o_i <= -181;
                   1'b1 : o_i <= 181;
                endcase
            end
            else if (i_mod == 2) begin // 16QAM
                case (r_shift_reg[3:2])
                   2'b00 : o_i <= -243;
                   2'b01 : o_i <= -81;
                   2'b11 : o_i <= 81;
                   2'b10 : o_i <= 243;
                endcase
            end
            else begin // 64QAM
                case (r_shift_reg[5:3])
                   3'b000 : o_i <= -277;
                   3'b001 : o_i <= -197;
                   3'b011 : o_i <= -119;
                   3'b010 : o_i <= -40;
                   3'b110 : o_i <= 40;
                   3'b111 : o_i <= 119;
                   3'b101 : o_i <= 197;
                   3'b100 : o_i <= 277;
                endcase
            end
        end
    end
end

always @(posedge i_clk or negedge i_rst_n) begin
    if (~i_rst_n) begin
        o_q <= 0;
    end
    else begin
        if (r_cnt == 7) begin
            if (i_mod == 0) begin // BPSK
                case (r_shift_reg[0])
                   0 : o_q <= 0;
                endcase
            end
            else if (i_mod == 1) begin // QPSK
                case (r_shift_reg[0])
                   1'b0 : o_q <= -181;
                   1'b1 : o_q <= 181;
                endcase
            end
            else if (i_mod == 2) begin // 16QAM
                case (r_shift_reg[1:0])
                   2'b00 : o_q <= -243;
                   2'b01 : o_q <= -81;
                   2'b11 : o_q <= 81;
                   2'b10 : o_q <= 243;
                endcase
            end
            else begin // 64QAM
                case (r_shift_reg[2:0])
                   3'b000 : o_q <= -277;
                   3'b001 : o_q <= -197;
                   3'b011 : o_q <= -119;
                   3'b010 : o_q <= -40;
                   3'b110 : o_q <= 40;
                   3'b111 : o_q <= 119;
                   3'b101 : o_q <= 197;
                   3'b100 : o_q <= 277;
                endcase
            end
        end
    end
end

endmodule