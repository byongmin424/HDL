module first_module (
    input   wire    first_in1,
    input   wire    first_in2,
    output  wire    first_out1,
    output  wire    first_out2,
    output  wire    first_out3       
);

assign  first_out1 = first_in1 & first_in2;
assign  first_out2 = first_in1 | first_in2;
assign  first_out3 = first_in1 ^ first_in2;
    
endmodule