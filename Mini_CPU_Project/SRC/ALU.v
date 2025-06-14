module alu(
    input wire[7:0] a;
    input wire[7:0] b;
    output reg [7:0] result;
);
    always @(*) begin
        result = a + b;
    end
endmodule