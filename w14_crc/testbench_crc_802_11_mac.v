`timescale 1ns/1ns

module testbench_crc_802_11_mac ();
    
reg r_clk;

initial begin
    r_clk = 0;
    forever begin
        #5 r_clk = ~r_clk;
    end
end

reg r_rst_n;
initial begin
    r_rst_n = 0;
    #40 r_rst_n = 1;
end

reg r_in_vld;
initial begin
    r_in_vld = 0;
    @ (posedge r_rst_n);
    repeat(10) @(posedge r_clk);
    r_in_vld = 1;
    repeat(80) @(posedge r_clk);
    r_in_vld = 0;
end

reg r_in;

integer         file;
reg     [7:0]   r_data;

initial begin
    file = $fopen("./test_input.txt","r");
    if (!file)
        $finish;

    r_data = 8'd0;
    r_in = 1'b0;
    @(posedge r_in_vld);
    while (!$feof(file)) begin
        $fscanf(file, "0x%h\n", r_data);
        $display("data = 0x%h", r_data);
        repeat(8) begin
            r_in = r_data[7];
            r_data[7:1] = r_data[6:0];
            @(posedge r_clk);
        end
    end

    $fclose(file);
end



wire w_tx_out_vld;
wire w_tx_out;
crc_802_11_mac      tx_crc_802_11_mac
(
    .i_rst_n        (r_rst_n        ),
    .i_clk          (r_clk          ),
    .i_in_vld       (r_in_vld       ),    
    .i_in           (r_in           ),
    .o_out_vld      (w_tx_out_vld   ),
    .o_out          (w_tx_out       )
);

endmodule