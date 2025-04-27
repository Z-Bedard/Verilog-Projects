//4-bit Counter Project
//Uses the clk cycles to count up

module counter(
    input wire clk,     // Clock input (happens on rising edge)
    input wire reset,   // Reset input (asynchronously resets count to 0)
    input wire enable,  // Enable input (Only counts up if this input is 1)
    input wire up_down,  // Up_Down input (1 = count up, 0 = count down)
    output reg [3:0] count // 4-bit output that shows the current number
);


always @(posedge clk or posedge reset) begin
    if (reset) begin // If the reset has been pressed reset the count to 0
        count <= 4'b0000;
    end
    else if (enable) begin // If enable has been pressed then start counting every clk cycle
        if (up_down)
            count <= count + 1;
        else begin
            if (count == 0) // This makes the counter go no lower than 0
                count <= 0; 
            else
                count <= count - 1;
        end
    end // If enable is now pressed (set to low/0) remain at the current count
end
endmodule