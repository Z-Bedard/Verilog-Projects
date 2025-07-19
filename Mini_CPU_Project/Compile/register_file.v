module register_file(
    input wire clk,
    input wire reset,
    input wire [rs1], //first arguement
    input wire [rs2], //Second arguement
    input wire [rd],  //Destination register
    input wire write_en, //Enable write
    input wire [7:0] write_data, //Data to be written to rd
    output wire [7:0] read_data1, //rs1 value
    output wire [7:0] read_data2 //rs2 value
);

    //Regsiters are stored as arrays so [3:0] means we have 4 registers
    reg[7:0] registers[3:0];

    always @(posedge clk or posedge reset) begin //On every rising edge
        if (reset) begin //If reset is pushed erase every thing
            register[0] <= 8'b0;
            register[1] <= 8'b0;
            register[2] <= 8'b0;
            register[3] <= 8'b0;
        end else if (write_en) begin //if there's a write happening then change the value of rd
            register[rd] <= write_data;
        end
    end

    // Set the values of read_data 1 and 2 
    assign read_data1 = register[rs1];
    assign read_data2 = register[rs2];
endmodule