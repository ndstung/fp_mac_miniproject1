`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2024 05:13:10 AM
// Design Name: 
// Module Name: tb_fp_mac_unpipelined
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_fp_mac;

    // Inputs
    reg [15:0] A;
    reg [15:0] B;
    reg [15:0] C;

    // Output
    wire [15:0] Result;

    // Instantiate the MAC unit
    fp_mac uut (
        .A(A),
        .B(B),
        .C(C),
        .Result(Result)
    );

    initial begin
        // Initialize inputs
        A = 16'h3C00;  // 1.0 in half-precision
        B = 16'h4000;  // 2.0 in half-precision
        C = 16'h3800;  // 0.5 in half-precision

        #10;
        
        A = 16'hC000;  // -2.0 in half-precision
        B = 16'h4000;  // 2.0 in half-precision
        C = 16'h3C00;  // 1.0 in half-precision

        #10;

        A = 16'h3E00;  // 1.5 in half-precision
        B = 16'h4200;  // 3.5 in half-precision
        C = 16'h3F00;  // 1.75 in half-precision

        #10;
        
        $finish;
    end

    // Monitor changes in the output
    initial begin
        $monitor("At time %0dns: A = %h, B = %h, C = %h, Result = %h", $time, A, B, C, Result);
    end

endmodule


