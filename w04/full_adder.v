module full_adder (
    input   wire    i_a,
    input   wire    i_b,
    input   wire    i_cin,
    output  wire    o_sum,
    output  wire    o_cout
);

wire w_m;

assign w_m = i_a ^ i_b;
assign o_sum = w_m ^ i_cin;
assign o_cout = (i_cin & w_m) | (i_a & i_b);

endmodule


// module full_adder
// (
//   input   wire    i_a,
//   input   wire    i_b,
//   input   wire    i_cin,
//   output  wire    o_sum,
//   output  wire    o_cout
// );

// wire w_sum;
// wire w_cin_1, w_cin_2;

// half_adder  u_ha_1
// (
//   .i_a    	  (i_a),
//   .i_b      	(i_b),
//   .o_carry   (w_cin_1   ),
//   .o_sum     (w_sum   )
// );



// half_adder  u_ha_2
// (
//   .i_a       (w_sum   ),
//   .i_b       (i_cin),
//   .o_carry   (w_cin_2   ),
//   .o_sum     (o_sum   )
// );


// wire w_cout = w_cin_1 | w_cin_2;

// assign o_cout = w_cout;
// /*  
// wire w_m;
 
// assign w_m = i_a ^ i_b;
// assign o_sum  = w_m ^ i_cin;
// assign o_cout = (i_cin & w_m) | (i_a & i_b);
// */  
// endmodule