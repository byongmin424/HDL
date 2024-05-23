module first_module (
    input   wire    first_in1,
    input   wire    first_in2,
    output  wire    first_out1
);

assign  first_out1 = first_in1 & first_in2;

endmodule