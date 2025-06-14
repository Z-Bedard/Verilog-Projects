module instr_mem(
    input wire [3:0] addr; //Address from PC
    output wire [7:0] data; //8-bit instruction
)
    reg[7:0] rom[15:0]; //16-bit instructions from 0 to 15

    initial begin
        //Hard code instructions as we don't have an input with the sims
        rom[0] = 8'b00_00_0101; //Load R0 with 5
        rom[1] = 8'b00_01_0011; //Load R1 with 3
        rom[2] = 8'b01_10_01_00; //Add R0 and R1 together and store in R2
        rom[3] = 8'b11_10_0100; //Store the new value in R2 in memory

        //Fill remaining with no-ops
        rom[4] = 8'b00000000;
        rom[5] = 8'b00000000;
        rom[6] = 8'b00000000;
        rom[7] = 8'b00000000;
        rom[8] = 8'b00000000;
        rom[9] = 8'b00000000;
        rom[10] = 8'b00000000;
        rom[11] = 8'b00000000;
        rom[12] = 8'b00000000;
        rom[13] = 8'b00000000;
        rom[14] = 8'b00000000;
        rom[15] = 8'b00000000;
    end

    assign data = rom[addr]; 
endmodule