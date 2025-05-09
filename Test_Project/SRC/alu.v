//alu.v
//4-bit alu

//This is comparible to the Entity in VHDL
module alu(
    input wire [3:0] a, //The square brackets show the bit length of each value
    input wire [3:0] b, //Variables created, 2 input and 3 output all dependent on the operation
    input wire [1:0] sel, //Selector variable to decide on the operation
    output reg [3:0] result //4-bit addition
);

//This is comparible to the Architecture in VHDL
always @(*) begin
    result = 4'b0000;
        case(sel) //Select operation based on the value of sel
            2'b00: result = a + b; //Add op
            2'b01: result = a & b; //AND op
            2'b10: result = a | b; //OR op
            2'b11: result = a ^ b; //XOR op
        endcase
    end
endmodule