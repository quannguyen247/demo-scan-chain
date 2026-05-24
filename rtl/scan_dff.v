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
        if (rst) 
            q <= 1'b0;
        else if (scan_en) 
            q <= scan_in;
        else 
            q <= d;
    end

endmodule