module ALU_Decoder(
    input  [1:0] ALUOp,
    input  [2:0] funct3,
    input  [6:0] funct7,
    input  [6:0] op,
    output reg [2:0] ALUControl
);

// ALU Control Encoding
// 000 -> ADD
// 001 -> SUB
// 010 -> AND
// 011 -> OR
// 100 -> SLT

always @(*) begin
    case(ALUOp)
        2'b00: ALUControl = 3'b000; // Load/Store -> ADD

        2'b01: ALUControl = 3'b001; // Branch -> SUB

        2'b10: begin                 // R-type
            case(funct3)
                3'b000: begin
                    if (funct7 == 7'b0100000)
                        ALUControl = 3'b001; // SUB
                    else
                        ALUControl = 3'b000; // ADD
                end
                3'b111: ALUControl = 3'b010; // AND
                3'b110: ALUControl = 3'b011; // OR
                3'b010: ALUControl = 3'b100; // SLT
                default: ALUControl = 3'b000;
            endcase
        end

        default: ALUControl = 3'b000;
    endcase
end

endmodule
