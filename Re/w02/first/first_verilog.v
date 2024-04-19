module fist_verilog();

wire first_wire;
reg  first_reg;

assign first_wire = 1;

initial begin
    first_reg = 0;
end

initial begin
    $dumpfile("first_verilog.vcd");
    $dumpvars(1);
end

endmodule