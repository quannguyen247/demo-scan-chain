`timescale 1ns/1ps

module counter_scan (
    input clk,
    input rst,
    input en,
    input scan_en,
    input scan_in,
    output scan_out,
    output [3:0] q
);

    wire [3:0] next_q;
    assign next_q = en ? (q + 1'b1) : q;

    scan_dff u_scan_dff0 (
        .clk(clk),
        .rst(rst),
        .scan_en(scan_en),
        .d(next_q[0]),
        .scan_in(scan_in),
        .q(q[0])
    );

    scan_dff u_scan_dff1 (
        .clk(clk),
        .rst(rst),
        .scan_en(scan_en),
        .d(next_q[1]),
        .scan_in(q[0]),
        .q(q[1])
    );

    scan_dff u_scan_dff2 (
        .clk(clk),
        .rst(rst),
        .scan_en(scan_en),
        .d(next_q[2]),
        .scan_in(q[1]),
        .q(q[2])
    );

    scan_dff u_scan_dff3 (
        .clk(clk),
        .rst(rst),
        .scan_en(scan_en),
        .d(next_q[3]),
        .scan_in(q[2]),
        .q(q[3])
    );
   
    assign scan_out = q[3];

endmodule