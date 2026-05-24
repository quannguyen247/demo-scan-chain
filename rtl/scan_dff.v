`timescale 1ns/1ps

module scan_dff (
    input clk,
    input rst,
    input scan_en,
    input d,
    input scan_in,
    output reg q
);

    always @(posedge clk) begin
        if (rst) begin
            q <= 1'b0;
        end
        else if (scan_en) begin
            q <= scan_in;
        end
        else begin
            q <= d;
        end
    end

endmodule