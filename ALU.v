// module alu(A,B,ALUControl,Z,N,V,C,Result);
// input [31:0] A,B;
// input [2:0] ALUControl;
// output [31:0] Result;
// output Z,N,V,C;
// wire [31:0] a_and_b;
// wire [31:0] a_or_b;
// wire [31:0] notb;
// wire [31:0] mux_1;
// wire [31:0] mux_2;
// wire [31:0] sum;
// wire cout;
// assign slt ={32'0000000000000000000000000000000000000, sum[31]};
// assign a_and_b = A & B;
// assign a_or_b = A | B;
// assign notb = ~B;
// assign mux_1 = (ALUControl[0]=1'b0)?B:not_B;
// assign {sum,cout} = A + mux_1 +ALUControl[0];
// assign mux_2 = (ALUControl[2:0]= 3'b000)? sum:
//                 (ALUControl[2:0]= 3'b001)? sum:
//                  (ALUControl[2:0]= 3'b010)? a_and_b:
//                  (ALUControl[2:0]= 3'b011)? a_or_b:
//                  (ALUControl[2:0]= 3'b101)? slt:32'h0000000000000000000000000000000000000;
// assign Result = mux_2;
// end module

// Copyright 2023 MERL-DSU

//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at

//        http://www.apache.org/licenses/LICENSE-2.0

//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.

module ALU (A,B,Result,ALUControl,OverFlow,Carry,Zero,Negative);

    input [31:0]A,B;
    input [2:0]ALUControl;
    output Carry,OverFlow,Zero,Negative;
    output [31:0]Result;

    wire Cout;
    wire [31:0]Sum;

    assign {Cout,Sum} = (ALUControl[0] == 1'b0) ? A + B :
                                          (A + ((~B)+1)) ;
    assign Result = (ALUControl == 3'b000) ? Sum :
                    (ALUControl == 3'b001) ? Sum :
                    (ALUControl == 3'b010) ? A & B :
                    (ALUControl == 3'b011) ? A | B :
                    (ALUControl == 3'b101) ? {{31{1'b0}},(Sum[31])} : {32{1'b0}};
    
    assign OverFlow = ((Sum[31] ^ A[31]) & 
                      (~(ALUControl[0] ^ B[31] ^ A[31])) &
                      (~ALUControl[1]));
    assign Carry = ((~ALUControl[1]) & Cout);
    assign Zero = &(~Result);
    assign Negative = Result[31];

endmodule