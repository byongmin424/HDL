`timescale 1ns/1ns

module tb_alu_8bit();

reg	[2:0]	r_op;
reg	[7:0]	r_a, r_b;

initial
begin
	r_op = 0;   r_a = 0;    r_b = 0;

    // Addition without overflow
    #10 r_op = 0;   r_a = 8'd25;    r_b = 8'd77;

    // Addition with overflow
    #10 r_op = 0;   r_a = 8'd50;    r_b = 8'd110;

    // Addition with overflow
    #10 r_op = 0;   r_a = -8'd50;    r_b = -8'd99;

    // Addition with zero
    #10 r_op = 0;   r_a = 8'd111;    r_b = -8'd111;

    // Subtraction1 without overflow
    #10 r_op = 1;   r_a = 8'd100;    r_b = 8'd45;

    // Subtraction1 with overflow
    #10 r_op = 1;   r_a = 8'd57;    r_b = -8'd86;

    // Subtraction1 with overflow
    #10 r_op = 1;   r_a = -8'd62;    r_b = 8'd93;

    // Subtraction1 with zero
    #10 r_op = 1;   r_a = 8'd123;    r_b = 8'd123;

    // Subtraction2 without overflow
    #10 r_op = 2;   r_a = 8'd100;    r_b = 8'd45;

    // Subtraction2 with overflow
    #10 r_op = 2;   r_a = 8'd57;    r_b = -8'd86;

    // Subtraction2 with overflow
    #10 r_op = 2;   r_a = -8'd62;    r_b = 8'd93;

    // Subtraction2 with zero
    #10 r_op = 2;   r_a = 8'd78;    r_b = 8'd78;

    // AND
    #10 r_op = 3;   r_a = 8'b11111111;  r_b = 8'b01010101;

    // AND with zero
    #10 r_op = 3;   r_a = 8'b01010101;  r_b = 8'b10101010;

    // OR
    #10 r_op = 4;   r_a = 8'b11110000;  r_b = 8'b11001100;

    // OR with zero
    #10 r_op = 4;   r_a = 8'b00000000;  r_b = 8'b00000000;

    // XOR
    #10 r_op = 5;   r_a = 8'b00001111;  r_b = 8'b00110011;

    // XOR with zero
    #10 r_op = 5;   r_a = 8'b11110000;  r_b = 8'b11110000;

    // NOT
    #10 r_op = 6;   r_a = 8'b11001100;  r_b = 8'b00000000;

    // NOT
    #10 r_op = 6;   r_a = 8'b11111111;  r_b = 8'b00000000;

    // Compare Equal
    #10 r_op = 7;   r_a = 8'd100;    r_b = 8'd100;

    // Compare Not Equal
    #10 r_op = 7;   r_a = 8'd100;    r_b = 8'd101;

    // Compare Greater A
    #10 r_op = 7;   r_a = 8'd100;    r_b = 8'd10;

    // Compare Greater B
    #10 r_op = 7;   r_a = 8'd100;    r_b = 8'd110;
end

wire    [7:0]   w_result, w_flag;

alu_8bit_me    u_dut
(
    .i_op           (r_op           ),
    .i_a            (r_a            ),
    .i_b            (r_b            ),
    .o_result       (w_result       ),
    .o_flag         (w_flag         )
);

initial begin
    $dumpfile("tb_alu.vcd");
    $dumpvars(1);
end

endmodule
