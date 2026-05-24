`timescale 1ns/1ps

module counter_scan_tb;

    reg clk;
    reg rst;
    reg en;
    reg scan_en;
    reg scan_in;

    wire scan_out;
    wire [3:0] q;

    reg [3:0] scanned_data;
    integer i;

    counter_scan dut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .scan_en(scan_en),
        .scan_in(scan_in),
        .scan_out(scan_out),
        .q(q)
    );

    always #5 clk = ~clk;

    task scan_load;
        input [3:0] data;
        
        begin
            scan_en = 1'b1;
            en = 1'b0;

            for (i = 3; i >= 0; i = i - 1) begin
                @(negedge clk);
                scan_in = data[i];
                @(posedge clk);
                #1;
            end
        end
    endtask

    task scan_read;
        begin
            scan_en = 1'b1;
            en = 1'b0;
            scanned_data = 4'b0000;

            for (i = 3; i >= 0; i = i - 1) begin
                @(negedge clk);
                scanned_data[i] = scan_out;
                scan_in = 1'b0;
                @(posedge clk);
                #1;
            end
        end
    endtask

    initial begin
        $dumpfile("results/counter_scan.vcd");
        $dumpvars(0, counter_scan_tb);

        clk = 0;
        rst = 1;
        en = 0;
        scan_en = 0;
        scan_in = 0;

        repeat (2) @(posedge clk);
        rst = 0;

        en = 1;
        scan_en = 0;
        repeat (4) @(posedge clk);
        #1;

        $display("Normal counter mode, q = %b", q);

        scan_load(4'b1010);
        $display("After scan load, q = %b", q);

        if (q !== 4'b1010) begin
            $display("ERROR: Scan load failed.");
            $finish;
        end

        scan_en = 0;
        en = 1;
        @(posedge clk);
        #1;

        $display("After one capture clock, q = %b", q);

        scan_read();
        $display("Scanned out data = %b", scanned_data);

        if (scanned_data !== 4'b1011) begin
            $display("ERROR: Scan read failed.");
            $finish;
        end

        $display("SCAN CHAIN DEMO PASSED.");
        $finish;
    end

endmodule