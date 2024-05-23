
`timescale 1ns/10ps

module tb_modulator ();
    
reg r_clk;
initial begin
    r_clk = 0;
    forever begin
        #6.25 r_clk = ~r_clk;
    end
end

reg r_rst_n;
initial begin
    r_rst_n = 0;
    #40 r_rst_n = 1;
end

reg r_en;
initial begin
    r_en = 0;
    @(posedge r_rst_n);
    repeat(10) @(posedge r_clk);


    forever begin
        r_en = 1;
        repeat(80) @(posedge r_clk);
        r_en = 0;
        repeat(20) @(posedge r_clk);
    end
    
end

reg [1:0] r_mod;
initial begin
    r_mod = 2'b00;
    forever begin
        @(negedge r_en);
        repeat(10) @(posedge r_clk);
        r_mod = r_mod + 2'd1;
    end
end

reg r_data_vld;
initial begin
    r_data_vld = 0;
    forever begin
        if (r_en)
        begin
            case (r_mod)
                2'b00 : begin
                    r_data_vld = 1;
                    @(posedge r_clk);
                    r_data_vld = 0;
                    repeat(7) @(posedge r_clk);
                end
                2'b01 : begin
                    r_data_vld = 1;
                    repeat(2) @(posedge r_clk);
                    r_data_vld = 0;
                    repeat(6) @(posedge r_clk);
                end
                2'b10 : begin
                    r_data_vld = 1;
                    repeat(4) @(posedge r_clk);
                    r_data_vld = 0;
                    repeat(4) @(posedge r_clk);
                end
                2'b11 : begin
                    r_data_vld = 1;
                    repeat(6) @(posedge r_clk);
                    r_data_vld = 0;
                    repeat(2) @(posedge r_clk);
                end
            endcase
        end
    else
        @(posedge r_en);
    end
end

reg r_data;
always @(posedge r_clk) begin
    if (~r_rst_n)
        r_data = 0;
    else begin
        if (r_data_vld)
            r_data = $urandom;
    end
end
endmodule