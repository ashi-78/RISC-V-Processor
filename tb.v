module tb();

    reg clk, rst;

    // Reset sequence
    initial begin
        clk = 0;
        rst = 0;
        #200;
        rst = 1;   // release reset
    end

    // Clock
    always #50 clk = ~clk;

    // Monitor pipeline activity
    initial begin
        $monitor("Time=%0t PC=%h InstrF=%h InstrD=%h",
                 $time, dut.Fetch.PCF, dut.Fetch.InstrF, dut.InstrD);
    end

    // Debug after pipeline fills (wait long enough!)
    initial begin
        #600;
        $display("RegWriteE=%b RegWriteW=%b RDW=%d ResultW=%d",
            dut.RegWriteE, dut.RegWriteW, dut.RDW, dut.ResultW);
    end

    // Final register dump and finish simulation
    initial begin
// Wait until final result is written back
    wait(dut.RegWriteW && dut.RDW == 10);  // x10 is final register

    #150;  // small buffer

        $display("\nFinal Registers:");
        $display("x5 = %0d", dut.Decode.rf.Register[5]);
        $display("x6 = %0d", dut.Decode.rf.Register[6]);
        $display("x7 = %0d", dut.Decode.rf.Register[7]);
        $display("x8 = %0d", dut.Decode.rf.Register[8]);
        $display("x9 = %0d", dut.Decode.rf.Register[9]);
        $display("x10 = %0d", dut.Decode.rf.Register[10]);
        $display("Last InstrD = %h", dut.InstrD);
        $finish;   // 🔴 REQUIRED to end simulation
    end

    // VCD dump
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
    end

    Pipeline_top dut (.clk(clk), .rst(rst));

endmodule
