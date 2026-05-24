`timescale 1ns/1ps

module counter_tb;

    reg clk;
    reg rst;
    reg en;
    wire [3:0] q;

    counter dut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("results/counter.vcd");
        $dumpvars(0, counter_tb);

        clk = 0;
        rst = 1;
        en = 0;

        #20;
        rst = 0;
        en = 1;

        #100;
        en = 0;

        #30;
        $finish;
    end

endmodule