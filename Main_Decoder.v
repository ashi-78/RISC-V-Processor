module Main_Decoder(
    input  [6:0] Op,
    output RegWrite,
    output [1:0] ImmSrc,
    output MemWrite,
    output ResultSrc,
    output Branch,
    output ALUSrc,
    output [1:0] ALUOp
);

// Opcodes
// R-type = 0110011
// I-type = 0010011  (ADDI)
// Load   = 0000011  (LW)
// Store  = 0100011  (SW)
// Branch = 1100011  (BEQ)

assign RegWrite = (Op == 7'b0110011) |  // R-type
                  (Op == 7'b0010011) |  // ADDI  ← CRITICAL
                  (Op == 7'b0000011);   // LW

assign ALUSrc   = (Op == 7'b0010011) |  // ADDI
                  (Op == 7'b0000011) |  // LW
                  (Op == 7'b0100011);   // SW

assign MemWrite = (Op == 7'b0100011);   // SW
assign ResultSrc= (Op == 7'b0000011);   // LW writes memory data
assign Branch   = (Op == 7'b1100011);   // BEQ

assign ALUOp = (Op == 7'b0110011) ? 2'b10 :  // R-type
               (Op == 7'b1100011) ? 2'b01 :  // Branch
                                    2'b00;   // ADDI, LW, SW

assign ImmSrc = (Op == 7'b0100011) ? 2'b01 : // S-type
                (Op == 7'b1100011) ? 2'b10 : // B-type
                                     2'b00;  // I-type

endmodule