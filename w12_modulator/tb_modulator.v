`timescale 1ns/10ps
// 12.5ns : 80Mhz clock 주기
// 6.25ns 동안 0, 6.25ns 동안 1
// 0.01ns단위 까지 표현해야함.
// 0.01ns = 10ps

module tb_modulator();



reg r_clk;
initial begin
    r_clk = 0;
    forever begin
            #6.25 r_clk = ~r_clk;
    end
end

// 40ns 후에 reset이 풀린다.
reg r_rst_n;
initial begin
    r_rst_n = 0;
    #40 r_rst_n = 1;
end

// 80cycle동안 1, 20cycle동안 0을 반복
reg r_en;
initial begin
    r_en = 0;
    // Reset이 풀릴 떄까지 대기
    @(posedge r_rst_n);
    // Reset이 풀리고 10cycle 후에 시작
    repeat(10) @(posedge r_clk);

    forever begin
        r_en = 1;
        repeat(80) @(posedge r_clk);
        r_en = 0;
        repeat(20) @(posedge r_clk);
    end
end

// 00 : BPSK
// 01 : QPSK
// 10 : 16QAM
// 11 : 64QAM
reg [1:0] r_mod;
initial begin
    r_mod = 0;
    forever begin
        @(negedge r_en); // enable이 끝나고,
        repeat(10) @(posedge r_clk); // 10cycle 후에
        r_mod = r_mod + 1;
    end
end

// Enable이 1인 동안 0~7까지 순서를 표시한다.
reg [2:0] r_en_cnt;
always @(posedge r_clk or negedge r_rst_n) begin
    if (~r_rst_n)
        r_en_cnt <= 0;
    else begin
        if (r_en)
            r_en_cnt <= r_en_cnt + 1;
        else
        r_en_cnt <= 0;
    end
end

// leejins r_data_vld
// Modulation 방식에 따라서 입력 data가 유효한 부분 1로 표시
reg r_data_vld;
always @(*) begin
    case (r_mod)
        0 : r_data_vld = (r_en_cnt == 0)  & r_en;
        1 : r_data_vld = (r_en_cnt <  2)  & r_en;
        2 : r_data_vld = (r_en_cnt <  4)  & r_en;
        3 : r_data_vld = (r_en_cnt <  6)  & r_en;
    endcase
end
// initial begin
//     r_data_vld = 0;
//     forever begin
//         if (r_en) begin
//             case (r_mod)
//                 0 : begin
//                     r_data_vld = 1;
//                     @(posedge r_clk);
//                     r_data_vld = 0;
//                     repeat(7) @(posedge r_clk);
//                 end
//                 1 : begin
//                     r_data_vld = 1;
//                     repeat(2) @(posedge r_clk);
//                     r_data_vld = 0;
//                     repeat(6) @(posedge r_clk);
//                 end
//                 2 : begin
//                     r_data_vld = 1;
//                     repeat(4) @(posedge r_clk);
//                     r_data_vld = 0;
//                     repeat(4) @(posedge r_clk);
//                 end
//                 3 : begin
//                     r_data_vld = 1;
//                     repeat(6) @(posedge r_clk);
//                     r_data_vld = 0;
//                     repeat(2) @(posedge r_clk);
//                 end
//             endcase
//         end
//         else
//             @(posedge r_en);
//     end
// end


reg r_data;
always @(posedge r_clk) begin
    if (~r_rst_n)
        r_data = 0;
    else begin
        if (r_data_vld)
            r_data = $urandom;
    end
end

digital_modulator       u_dut
(
    .i_rst_n            (r_rst_n    ),
    .i_clk              (r_clk      ),
    .i_en               (r_en       ),
    .i_data_vld         (r_data_vld ),
    .i_data             (r_data     ),
    .i_mod              (r_mod      ),
    .o_out_vld          (),
    .o_i                (),
    .o_q                ()
);

endmodule