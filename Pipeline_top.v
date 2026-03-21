



// `include "Fetch_cycle.v"
// `include "Decode_cycle.v"
// `include "Execute_cycle.v"
// `include "Memory_cycle.v"
// `include "Write_back_cycle.v"
// `include "PC.v"
// `include "PCAdder.v"
// `include "Mux.v"
// `include "Instruction_mem.v"
// `include "Control_Unit_Top.v"
// `include "Registerfile.v"
// `include "Sign_extend.v"
// `include "ALU.v"
// `include "Data_Mem.v"
// `include "Hazard_unit.v"
module Pipeline_top(
    input clk,
    input rst,
    output [31:0] debug_pc,
    output [31:0] debug_instr,
    output [31:0] debug_alu
);

// Control Wires
wire PCSrcE, RegWriteW, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE;
wire RegWriteM, MemWriteM, ResultSrcM, ResultSrcW;
wire [2:0] ALUControlE;
    // Register & Data Wires
    wire [4:0] RD_E, RD_M, RDW;
    wire [4:0] RS1_E, RS2_E;
    wire [1:0] ForwardAE, ForwardBE;
    wire [31:0] PC;   // added
    wire [31:0] PCTargetE, InstrD, PCD, PCPlus4D;
    wire [31:0] ResultW, RD1_E, RD2_E, Imm_Ext_E;
    wire [31:0] PCE, PCPlus4E, PCPlus4M, WriteDataM, ALU_ResultM;
    wire [31:0] PCPlus4W, ALU_ResultW, ReadDataW;
	 
assign debug_pc    = PC;
assign debug_instr = InstrD;
assign debug_alu   = ALU_ResultM;
// ================= FETCH STAGE =================
    Fetch_cycle Fetch (
        .clk(clk),
        .rst(rst),
        .PCSrcE(PCSrcE),
        .PCTargetE(PCTargetE),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D)
    );

    // ================= DECODE STAGE =================
    Decode_cycle Decode (
        .clk(clk),
        .rst(rst),
        .InstrD(InstrD),
        .PCD(PCD),
        .PCPlus4D(PCPlus4D),
        .RegWriteW(RegWriteW),
        .RDW(RDW),
        .ResultW(ResultW),
        .RegWriteE(RegWriteE),
        .ALUSrcE(ALUSrcE),
        .MemWriteE(MemWriteE),
        .ResultSrcE(ResultSrcE),
        .BranchE(BranchE),
        .ALUControlE(ALUControlE),
        .RD1_E(RD1_E),
        .RD2_E(RD2_E),
        .Imm_Ext_E(Imm_Ext_E),
        .RD_E(RD_E),
        .PCE(PCE),
        .PCPlus4E(PCPlus4E),
        .RS1_E(RS1_E),
        .RS2_E(RS2_E)
    );

    // ================= EXECUTE STAGE =================
   Execute_cycle Execute (
    .clk(clk),
    .rst(rst),
    .RegWriteE(RegWriteE),
    .ALUSrcE(ALUSrcE),
    .MemWriteE(MemWriteE),
    .ResultSrcE(ResultSrcE),
    .BranchE(BranchE),
    .ALUControlE(ALUControlE),

    .RD1_E(RD1_E),
    .RD2_E(RD2_E),
    .Imm_Ext_E(Imm_Ext_E),
    .RD_E(RD_E),
    .PCE(PCE),
    .PCPlus4E(PCPlus4E),

    .PCSrcE(PCSrcE),
    .PCTargetE(PCTargetE),

    .RegWriteM(RegWriteM),
    .MemWriteM(MemWriteM),
    .ResultSrcM(ResultSrcM),
    .RD_M(RD_M),
    .PCPlus4M(PCPlus4M),
    .WriteDataM(WriteDataM),
    .ALU_ResultM(ALU_ResultM),

    .ResultW(ResultW),
    .ALU_ResultM_in(ALU_ResultM),   // 🔥 CRITICAL
    .ForwardA_E(ForwardAE),
    .ForwardB_E(ForwardBE)
);

    // ================= MEMORY STAGE =================
    Memory_cycle Memory (
        .clk(clk),
        .rst(rst),
        .RegWriteM(RegWriteM),
        .MemWriteM(MemWriteM),
        .ResultSrcM(ResultSrcM),
        .RD_M(RD_M),
        .PCPlus4M(PCPlus4M),
        .WriteDataM(WriteDataM),
        .ALU_ResultM(ALU_ResultM),
        .RegWriteW(RegWriteW),
        .ResultSrcW(ResultSrcW),
        .RD_W(RDW),
        .PCPlus4W(PCPlus4W),
        .ALU_ResultW(ALU_ResultW),
        .ReadDataW(ReadDataW)
    );

    // ================= WRITE BACK STAGE =================
    Write_back_cycle WriteBack (
        .clk(clk),
        .rst(rst),
        .ResultSrcW(ResultSrcW),
        .PCPlus4W(PCPlus4W),
        .ALU_ResultW(ALU_ResultW),
        .ReadDataW(ReadDataW),
        .ResultW(ResultW)
    );

    // ================= HAZARD UNIT (OPTIONAL) =================
    Hazard_unit Forwarding_block (
        .rst(rst),
        .RegWriteM(RegWriteM),
        .RegWriteW(RegWriteW),
        .RD_M(RD_M),
        .RD_W(RDW),
        .Rs1_E(RS1_E),
        .Rs2_E(RS2_E),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE)
    );
    
endmodule