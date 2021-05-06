`timescale 1ns/1ps
//`timescale <time_unit>/<time_precision>

module alu(A,B,ALU_Sel,ALU_Out);
    input [5:0] A,B;            
    input [3:0] ALU_Sel;
    output [5:0] ALU_Out; 
    reg [5:0] ALU_Result;
    wire [6:0] tmp;
    assign ALU_Out = ALU_Result; // ALU out

always @(*)
    begin
        case(ALU_Sel)
        4'b0000: 
           ALU_Result = A & B ; //AND
        4'b0001: 
           ALU_Result = A | B ; //OR
        4'b0010: 
           ALU_Result = A ^ B;//XOR
        4'b0011: 
           ALU_Result = ~A;//COMPLEMENT
        4'b0100: 
           ALU_Result = A<<1;//LEFT SHIFT
        4'b0101: 
           ALU_Result = A>>1;//RIGHT SHIFT
        4'b0110: 
           ALU_Result = {A[4:0],A[5]};//CIRCULAR RIGHT SHIFT
        4'b0111:
           ALU_Result = {A[0],A[5:1]};//CIRCULAR LEFT SHIFT
        4'b1000: 
           ALU_Result = A<<<1;//ARITHEMETIC LEFT SHIFT
        4'b1001: 
           ALU_Result = A>>>1;//ARITHEMATIC RIGHT SHIFT

        default: ALU_Result = A; 
    endcase
end

endmodule

module tb_alu;

 reg[5:0] A,B;
 reg[3:0] ALU_Sel;
 wire[5:0] ALU_Out;
 wire CarryOut;

 alu test_unit(A,B,ALU_Sel,ALU_Out);
    initial begin
      #0     A = 6'b000111;B = 6'b010101; ALU_Sel = 4'b0000;
      #10    A = 6'b000111;B = 6'b010101; ALU_Sel = 4'b0001;
      #10    A = 6'b000111;B = 6'b010101; ALU_Sel = 4'b0010;
      #10    A = 6'b000111;B = 6'b010101; ALU_Sel = 4'b0011;
      #10    A = 6'b000111;B = 6'b010101; ALU_Sel = 4'b0100;
      #10    A = 6'b000111;B = 6'b010101; ALU_Sel = 4'b0101;
      #10    A = 6'b000111;B = 6'b010101; ALU_Sel = 4'b0110;
      #10    A = 6'b000111;B = 6'b010101; ALU_Sel = 4'b0111;
      #10    A = 6'b000111;B = 6'b010101; ALU_Sel = 4'b1000;
      #10    A = 6'b000111;B = 6'b010101; ALU_Sel = 4'b1001;
    end

    initial begin
        $monitor("a=%b b=%b ALU_Sel=%b ALU_Out=%b ",A,B,ALU_Sel,ALU_Out);
    end
      
endmodule