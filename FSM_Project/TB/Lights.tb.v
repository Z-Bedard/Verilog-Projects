`timescale 1ns/1ps //1ns cycles, 1ps precision

module Lights;
//Testbench signals
    reg clk;
    reg reset;
    wire [1:0] light_out; //Output

    lights uut(
        .clk(clk),
        .reset(reset),
        .light_out(light_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; //Make each cycle 5 time units (In this case 5 ns)
    end

    initial begin
        $monitor("Time = %0t | clk = %b | reset = %b | light = %b", $time, clk, reset, light_out); // Output all relevent signals

        // Start the sim with the following starting values
        reset = 1; // Start on Green
        #10;
        reset = 0; // Start fliping
        
        #200; // Let the states flip for 200ns to get the transitions

        // Assert Reset again to test if it resets
        reset = 1;
        #10;
        reset = 0;

        #150; // Run a few more times

        $stop; // End sim
    end
endmodule