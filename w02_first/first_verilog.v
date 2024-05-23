module first_verilog ();

wire first_wire;
reg first_reg;

assign #10 first_wire = 1;

initial begin
    first_reg = 0;
    #20 first_reg = 1;
    #30 first_reg = 0;
end

endmodule