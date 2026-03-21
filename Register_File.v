module Register_File(clk,rst,WE3,WD3,A1,A2,A3,RD1,RD2);

    input clk,rst,WE3;
    input [4:0]A1,A2,A3;
    input [31:0]WD3;
    output [31:0]RD1,RD2;

    reg [31:0] Register [31:0];
    integer i;

    // Initialize all registers to 0 (important for simulation)
    initial begin
        for(i=0;i<32;i=i+1)
            Register[i] = 32'd0;
    end

    // Write back stage (synchronous write)
    always @(posedge clk) begin
        if (WE3 && (A3 != 5'b00000))
            Register[A3] <= WD3;
    end

    // Read ports
    assign RD1 = (A1 == 5'b00000) ? 32'd0 : Register[A1];
    assign RD2 = (A2 == 5'b00000) ? 32'd0 : Register[A2];

endmodule