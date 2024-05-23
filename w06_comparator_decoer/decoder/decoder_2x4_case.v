module decoder_2x4_case (
    input   wire    [1:0]   i_a,
    output  reg     [3:0]   o_y
);

always @(i_a)
begin
    case (i_a)
        2'b00 :
            o_y = 4'b1011;
        2'b01 :
            o_y = 4'b0110;
        2'b10 :
            o_y = 4'b0101;
        2'b11 :
            o_y = 4'b1101;
    endcase 
end

endmodule