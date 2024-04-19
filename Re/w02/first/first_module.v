module first_module(
    input   wire    [1:0]    first_in,
    output  wire    [2:0]    first_out1,
    output  wire    [2:0]    first_out2,
    output  wire    [2:0]    first_out3
);

assign first_out1= first_in[0] & first_in[1];
assign first_out2= first_in[0] | first_in[1];
assign first_out3= first_in[0] ^ first_in[1];

endmodule