module Fetch_cycle(clk, rst, PCSrcE, PCTargetE, InstrD, PCD, PCPlus4D);

    // Inputs & Outputs
    input clk, rst;
    input PCSrcE;
    input [31:0] PCTargetE;
    output [31:0] InstrD;
    output [31:0] PCD, PCPlus4D;

    // Interim wires
    wire [31:0] PC_F, PCF, PCPlus4F;
    wire [31:0] InstrF;

    // Pipeline registers
    reg [31:0] InstrF_reg;
    reg [31:0] PCF_reg, PCPlus4F_reg;

    // ----------- FIXED: Use 2-input Mux for PC selection -----------
    // If PCSrcE = 0 → PC + 4
    // If PCSrcE = 1 → Branch target
 Mux PC_MUX (
    .a(PCPlus4F),
    .b(PCTargetE),
    .s(PCSrcE),
    .c(PC_F)
);

    // Program Counter
    PC Program_Counter (
        .clk(clk),
        .rst(rst),
        .PC(PCF),
        .PC_Next(PC_F)
    );

    // Instruction Memory
    Instruction_Memory IMEM (
        .rst(rst),
        .A(PCF),
        .RD(InstrF)
    );

    // PC + 4 Adder
    PC_Adder PC_adder (
        .a(PCF),
        .b(32'h00000004),
        .c(PCPlus4F)
    );
initial begin
    $monitor("Time=%0t PC=%h InstrF=%h InstrD=%h", $time, PCF, InstrF, InstrD);
end
    // Fetch → Decode pipeline registers
  always @(posedge clk or negedge rst) begin
    if(!rst) begin
        InstrF_reg   <= 32'h00000000;
        PCF_reg      <= 32'h00000000;
        PCPlus4F_reg <= 32'h00000000;
    end
    else begin
        // latch previous cycle values correctly
        InstrF_reg   <= InstrF;
        PCF_reg      <= PCF;
        PCPlus4F_reg <= PCPlus4F;
    end
end

    // Outputs to Decode stage
  assign InstrD   = InstrF_reg;
assign PCD      = PCF_reg;
assign PCPlus4D = PCPlus4F_reg;
endmodule