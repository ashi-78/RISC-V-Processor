module Write_back_cycle(clk, rst, ResultSrcW, PCPlus4W, ALU_ResultW, ReadDataW, ResultW);

    input clk, rst, ResultSrcW;
    input [31:0] PCPlus4W, ALU_ResultW, ReadDataW;
    output [31:0] ResultW;

    assign ResultW = (ResultSrcW) ? ReadDataW : ALU_ResultW;

endmodule