//Mini CPU project to implement RISC-V instructions
/*
8-bit processor

Opcode legend (Bits 7-6):
00: Load Immediate
01: ADD 
10: ADDI
11: Store word

Destination register - Bits 5-4
RS1 - Bits 3-2
RS2 - Bits 1-0
*/

module cpu (
    input wire clk, //clk signal
    input wire reset //Reset signal (active high)
);

    //Program Counter
    reg[3:0] pc;

    //Instruction Register
    reg[7:0] instr;

    //Instruction Fields
    wire[1:0] opcode = instr[7:6];
    wire[1:0] rd = instr[5:4];
    wire[1:0] rs1 = instr[3:2]; //Argument register 1
    wire[1:0] rs2 = instr[1:0]; //Argument register 2
    wire[3:0] imm = instr[3:0]; //Immediate value (4-bit)
    wire[3:0] addr = instr[3:0]; //Address for store words

    //Register data
    wire[7:0] reg_data1, reg_data2; //Register data used in ALU
    reg[7:0] write_data; //Register address for data being written
    reg write_enable; //enable signal for ALU

    //register file module instantiation
    register_file rf(
        .clk(clk),
        .reset(reset),
        .rs1(rs1), //Source Register 1
        .rs2(rs2), //Source Register 2
        .rd(rd),   //Destination Register
        .write_en(reg_write_en),
        .write_data(reg_write_data),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    )

    wire[7:0] alu_result; //Wire for holding ALU result

    alu alu_inst( //ALU Instansiation 
        .a(reg_data1), //Operand A
        .b(reg_data2), //Operand B
        .result(alu_result) //ALU Output
    )

    // Instantiate ROM
    instr_mem imem(
        .addr(pc),  //Addressed by PC
        .data(instr)    // 8-bit insturction output
    )

    // Instantiate RAM
    reg mem_write_data;
    reg[3:0] mem_addr;
    reg[7:0] mem_write_data;
    wire[7:0] mem_read_data;

    // Instantiate Data Memory module
    data_mem dmem (
        .clk(clk),
        .addr(mem_addr),
        .write_en(mem_write_en),
        .write_data(mem_write_data),
        .read_data(mem_read_data)
    )


    //Control Logic
    always @(posedge clk or posedge reset) begin
        if(reset) begin //Reset on posedge then reset the PC and write signals
            pc <= 4'b0000;
            reg_write_en <= 0;
            mem_write_en <= 0;
        end else begin //Reset write signals without effecting the PC
            reg_write_en <= 0;
            mem_write_en <= 0;

            case (opcode) //Read the opcode of the instr value and see what the user wants
                2'b00: begin //LOAD Immediate Opcode
                    reg_write_en <= 1;
                    reg_write_data <= {4'b0000, imm}; //Zero expend the 4-bit immediate value to 8-bits
                end

                2'b01: begin //ADD two registers
                    reg_write_en <= 1;
                    reg_write_data <= alu_result;
                end

                2'b10: begin //ADDI Instruction
                    reg_write_en <= 1;
                    reg_write_data <= reg_data1 + {4'b0000, imm};
                end

                2'b11: begin //STORE Instruction
                    mem_write_en <= 1;
                    mem_addr <= addr; //Get memory address
                    mem_write_data <= reg_data1;
                end
            endcase
            pc <= pc + 1;
        end
    end
endmodule