module data_mem(
    input wire clk, //Clock input
    input wire [3:0] addr, //4-bit address
    input wire write_en, //Enable signal for data mem
    input wire [7:0] write_data, //data being written to the memory
    output wire [7:0] read_data //Data read from the memory
);

    // Declare memory array
    reg [7:0] memory [0:15];
    
    //Sync write (Rising edge of clk)
    always @(posedge clk) begin
        if (write_en) begin
            memory[addr] <= write_data;
        end
    end

    // Read Data
    assign read_data = memory [addr]
endmodule