module crc_802_11_mac(
    input   wire        i_rst_n,
    input   wire        i_clk,
    input   wire        i_in_vld,
    input   wire        i_in,
    output  wire        o_out_vld,
    output  wire        o_out
);


// CRC module 제어부 ///////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
reg     [1:0]   r_c_st; // current
reg     [1:0]   r_n_st; // next
reg     [4:0]   r_crc_out_cnt;

always @(posedge i_clk or negedge i_rst_n) begin
    if (~i_rst_n)
        r_c_st <= 0;
    else
        r_c_st <= r_n_st;
end

always @(posedge i_clk or negedge i_rst_n) begin
    if (~i_rst_n)
        r_crc_out_cnt <= 0;
    else begin
        if (r_n_st == 2'b10)
            r_crc_out_cnt <= r_crc_out_cnt + 1;
        else
            r_crc_out_cnt <= 0;
    end
end

always @(*) begin
    case (r_c_st)
        2'b00 : // IDLE State
        begin
            if (i_in_vld)
                r_n_st = 2'b01;
            else
                r_n_st = 2'b00;
        end
        2'b01 : // CRC Calculation State
        begin
            if (~i_in_vld)
                r_n_st = 2'b10;
            else
                r_n_st = 2'b01;
        end
        2'b10 : // CRC Bit Out State _출력 상태
        begin
            if (r_crc_out_cnt == 5'd31)
                r_n_st = 2'b00;
            else
                r_n_st = 2'b10;
        end
        default:
            r_n_st = 2'b00; 
    endcase
end
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////



// CRC 연산부 만들기 ///////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
reg     [31:0]   r_crc;
wire             w_xor_0;
assign w_xor_0 = r_crc[31] ^ i_in;

always @(posedge i_clk or negedge i_rst_n) begin
    if (~i_rst_n)
        r_crc <= 32'hFFFFFFFF;
    else begin
        if (i_in_vld) begin
            r_crc[0] <= w_xor_0;
            r_crc[1] <= r_crc[0] ^ w_xor_0;
            r_crc[2] <= r_crc[1] ^ w_xor_0;
            r_crc[3] <= r_crc[2];
            r_crc[4] <= r_crc[3] ^ w_xor_0;
            r_crc[5] <= r_crc[4] ^ w_xor_0;
            r_crc[6] <= r_crc[5];
            r_crc[7] <= r_crc[6] ^ w_xor_0;
            r_crc[8] <= r_crc[7] ^ w_xor_0;
            r_crc[9] <= r_crc[8];
            r_crc[10] <= r_crc[9] ^ w_xor_0;
            r_crc[11] <= r_crc[10] ^ w_xor_0;
            r_crc[12] <= r_crc[11] ^ w_xor_0;
            r_crc[15:13] <= r_crc[14:12];
            r_crc[16] <= r_crc[15] ^ w_xor_0;
            r_crc[21:17] <= r_crc[20:16];
            r_crc[22] <= r_crc[21] ^ w_xor_0;
            r_crc[23] <= r_crc[22] ^ w_xor_0;
            r_crc[25:24] <= r_crc[24:23];
            r_crc[26] <= r_crc[25] ^ w_xor_0;
            r_crc[31:27] <= r_crc[30:26];
        end
    end
end
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////


// CRC 비트 출력하기 ////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
wire    w_crc_out_time;
assign  w_crc_out_time = (r_n_st == 2'b10) | (r_c_st == 2'b10); // 현재가 출력상태 | 다음이 출력상태

always @(posedge i_clk or negedge i_rst_n) begin
    if (~i_rst_n)
        r_crc <= 32'hFFFFFFFF;
    else begin
        if (i_in_vld) begin
            r_crc[0] <= w_xor_0;
            r_crc[1] <= r_crc[0] ^ w_xor_0;
            r_crc[2] <= r_crc[1] ^ w_xor_0;
            r_crc[3] <= r_crc[2];
            r_crc[4] <= r_crc[3] ^ w_xor_0;
            r_crc[5] <= r_crc[4] ^ w_xor_0;
            r_crc[6] <= r_crc[5];
            r_crc[7] <= r_crc[6] ^ w_xor_0;
            r_crc[8] <= r_crc[7] ^ w_xor_0;
            r_crc[9] <= r_crc[8];
            r_crc[10] <= r_crc[9] ^ w_xor_0;
            r_crc[11] <= r_crc[10] ^ w_xor_0;
            r_crc[12] <= r_crc[11] ^ w_xor_0;
            r_crc[15:13] <= r_crc[14:12];
            r_crc[16] <= r_crc[15] ^ w_xor_0;
            r_crc[21:17] <= r_crc[20:16];
            r_crc[22] <= r_crc[21] ^ w_xor_0;
            r_crc[23] <= r_crc[22] ^ w_xor_0;
            r_crc[25:24] <= r_crc[24:23];
            r_crc[26] <= r_crc[25] ^ w_xor_0;
            r_crc[31:27] <= r_crc[30:26];
        end
        else if (w_crc_out_time) begin
            r_crc[31:1] <= r_crc[30:0];
            r_crc[0] <= 1;
        end
    end
end

assign o_out_vld = i_in_vld | w_crc_out_time;
assign o_out = (~w_crc_out_time) ? i_in : r_crc[31];
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////


endmodule