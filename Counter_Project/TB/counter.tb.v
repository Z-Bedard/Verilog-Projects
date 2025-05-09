//Test for the counter module

`timescale 1ns/1ps //Time unit is 1ns and precision is 1ps

module counterTest; // Use the already created module
    //Test signals
    reg clk;
    reg reset;
    reg enable;
    reg up_down;
    wire [3:0] count;

    //Instantiate the device under test conditions
    counter uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .up_down(up_down),
        .count(count)
    );

    // Set the clk to flip every 5ns (simulate the clk cycles)
    initial begin
        clk = 0;
        forever #5 clk = ~clk; //Clk will filp every 5ns
    end

    // Functionality Test
    initial begin
        // Output all the current values so we can see what's being output
        $monitor("Time = %0t | clk = %b | reset = %b | enable = %b | up_down = %b | count = %b", $time, clk, reset, enable, up_down, count);
        
        // Initializing signals
        reset = 1;
        enable = 0;
        up_down = 1;

        #10; // This acts like a cycle delay for 10ns
        reset = 0; //Release the reset function so we can start counting

        // Enable counting
        #10;
        enable = 1;

        // Let count for 20 cycles (each cycle is 5ns)
        #100; 

        //Stop counting and wait for 6 cycles
        enable = 0;
        #30;

        // Start counting again but decend this time
        enable = 1;
        up_down = 0; 
        #50;

        // Reset while it's running
        reset = 1;
        #10;
        reset = 0;

        // Restart counting
        up_down = 1;
        #50;

        // Terminate sim
        $stop;
    end
endmodule