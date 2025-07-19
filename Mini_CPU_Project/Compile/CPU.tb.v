`timescale 1ns / 1ps

module cpu_tb;

    // === Signals ===
    reg clk;
    reg reset;

    // Instantiate the CPU
    cpu uut (
        .clk(clk),
        .reset(reset)
    );

    // === Clock Generation (10ns period) ===
    always #5 clk = ~clk;

    // === Simulation Initialization ===
    initial begin
        // Initialize clock and reset
        clk = 0;
        reset = 1;

        // === Waveform dump setup ===
        $dumpfile("cpu_wave.vcd");       // VCD file for GTKWave
        $dumpvars(0, cpu_tb);            // Dump everything in cpu_tb scope

        // Hold reset for a few cycles
        #10 reset = 0;

        // Run simulation for 200ns (20 clock cycles)
        #200;

        // Optional: print memory/register contents
        $display("Memory[4] = %d", uut.dmem.memory[4]);
        $display("R0 = %d", uut.rf.registers[0]);
        $display("R1 = %d", uut.rf.registers[1]);
        $display("R2 = %d", uut.rf.registers[2]);
        $display("R3 = %d", uut.rf.registers[3]);

        $finish;
    end

endmodule