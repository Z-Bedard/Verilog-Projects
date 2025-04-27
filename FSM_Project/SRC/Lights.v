// Stop light control in Verilog (FSM practice)

module lights(
    input wire clk,           // Clk signal 
    input wire reset,         // Reset signal
    output wire[1:0] light_out // Output lights
);

reg[1:0] state; // Declared within the module body as they are internal signals (Not an input or an output)
reg[3:0] counter; // Create a counter to keep track of the clk cycles

assign light_out = state; // Set the output light to the state of the FSM
// "Always" will happen when the arguements passed through are met 
always @(posedge clk)
    if (reset) begin
        state <= 2'b00; // We're saying 00 is the Green state
        counter <= 4'b0000; // Initialize the counter to 0
    end
    else begin
        counter <= counter + 1;
        if(counter <= 4'd5)begin // Reset the counter after every 5 cycles
            counter <= 4'b0000;  // Reset the counter to 0 after those cycles have gone through
            case (state) // Transition between different colors
                2'b00: state <= 2'b01; // Green -> Yellow
                2'b01: state <= 2'b10; // Yellow -> Red
                2'b10: state <= 2'b00;  // Red -> Green
                default: state <= 2'b00; // If undefined then set the value to Green
            endcase
        end
    end
endmodule 