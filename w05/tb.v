`timescale 1ns / 1ns

module tb();

reg  [3:0]  r_a, r_b;
reg         r_cin;

initial
begin
    $dumpfile("tb_adder_4bit.vcd");
    $dumpvars(1);
end

// 각 i_a, i_b, i_cin 에 랜덤한 숫자 넣기
initial
begin
    r_a = 0;
    r_b = 0;
    r_cin = 0;

    repeat(20)
    begin
        #10;
        r_a = $urandom;
        r_b = $urandom;
        r_cin = $urandom;
    end
end

// 출력이 정확한지 판단할 수 있는 신호 만들기
wire    [4:0]  w_answer;
assign w_answer = r_a + r_b + r_cin;

wire    [3:0]  w_ref_sum; 
wire           w_ref_cout;
assign w_ref_sum = w_answer[3:0];
assign w_ref_cout = w_answer[4];

// 신호 instanciation & port mapping
wire    [3:0]   w_sum;
wire            w_cout;

adder_4bit  u_adder_4
(
    .i_a        (r_a    ),
    .i_b        (r_b    ),
    .i_cin      (r_cin  ),
    .o_sum      (w_sum  ),
    .o_cout     (w_cout )
);


always @(r_a or r_b or r_cin)
begin
    if ((w_sum == w_ref_sum) && (w_cout == w_ref_cout))
    begin
        $display("%d ns : Correct Operation", $time);
    end
    else
    begin
        $display("%d ns : Error", $time);
        $display("i_a = %d, i_b = %d, i_cin = %b, o_sum = %d, o_cout = %b",
                  r_a, r_b, r_cin, w_sum, w_cout);
        $stop;
    end
end


endmodule