// ===================================================
// adder_tb.v
// Testbench for the 2-bit adder module
// ===================================================

`timescale 1ns/1ps  // Simulation time unit = 1ns, precision = 1ps

module alu_tb;

    // Declare testbench signals
    reg  [3:0] a;     // 2-bit register for input 'a'
    reg  [3:0] b;     // 2-bit register for input 'b'
    reg  [1:0] sel;   // 2-bit selector for ALU
    wire [3:0] result;   // 2-bit wire for output 'sum' from the adder

    // Instantiate the Device Under Test (DUT)
    alu uut (           // 'uut' stands for Unit Under Test
        .a(a),            // Connect testbench signal 'a' to adder input 'a'
        .b(b),            // Connect testbench signal 'b' to adder input 'b'
        .sel(sel),
        .result(result)         // Connect adder output 'sum' to testbench wire 'sum'
    );

    // Initial block: runs once at time 0
    initial begin
        // Display header
        $display("Time | a    b   sel | result");
        $monitor("%4dns | %b %b %b | %b", $time, a, b, sel, result);

        // Test Addition (sel = 00)
        a = 4'b0011; b = 4'b0101; sel = 2'b00; #10;  // 3 + 5 = 8
        a = 4'b1001; b = 4'b0011; sel = 2'b00; #10;  // 9 + 3 = 12

        // Test AND (sel = 01)
        a = 4'b1100; b = 4'b1010; sel = 2'b01; #10;  // 1100 & 1010 = 1000

        // Test OR (sel = 10)
        a = 4'b1100; b = 4'b1010; sel = 2'b10; #10;  // 1100 | 1010 = 1110

        // End simulation
        $finish;
    end
    
endmodule