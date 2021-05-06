module claAdder(a,b,cin,sum,cout);
    input[3:0] a,b;
    input cin;
    
    output[3:0] sum;
    output cout;

    wire [4:1] c;
    wire [3:0] p;
    wire [3:0] g;

    assign 
        p0=(a[0]^b[0]),
        p1=(a[1]^b[1]),
        p2=(a[2]^b[2]),
        p3=(a[3]^b[3]);

    assign 
        g0=(a[0]&b[0]),
        g1=(a[1]&b[1]),
        g2=(a[2]&b[2]),
        g3=(a[3]&b[3]);

    assign 
        c0=cin,
        c1=g0|(p0&cin),
        c2=g1|(p1&g0)|(p1&p0&cin),
        c3=g2|(p2&g1)|(p2&p1&g0)|(p2&p1&p0&cin),
        c4=g3|(p3&g2)|(p3&p3&g1)|(p3&p2&p1&p0&cin);

    assign
        sum[0]=p0^c0,
        sum[1]=p1^c1,
        sum[2]=p2^c2,
        sum[3]=p3^c3;
    
    assign 
        cout=c4;

endmodule

module wallace(A,B,prod,co);
    //inputs and outputs
    input [3:0] A,B;
    output co;
    output [7:0] prod;
    input [7:0] a,b;
    output [7:0] sum;
    //internal variables.
    wire s11,s12,s13,s14,s15,s22,s23,s24,s25,s26,s32,s33,s34,s35,s36,s37;
    wire c11,c12,c13,c14,c15,c22,c23,c24,c25,c26,c32,c33,c34,c35,c36,c37;
    wire [6:0] p0,p1,p2,p3;

//initialize the p's.
    assign  p0 = A & {4{B[0]}};
    assign  p1 = A & {4{B[1]}};
    assign  p2 = A & {4{B[2]}};
    assign  p3 = A & {4{B[3]}};

//first stage
    half_adder ha11(p0[3],p1[2],s11,c11);
    half_adder ha12(p2[2],p3[3],s12,c12);

//second stage
    half_adder fa21 (p0[2],p1[1],s21,c21);
    full_adder fa22 (p2[1],p3[0],s11,s22,c22);
    full_adder fa23 (c11,p3[1],s12,s23,c23);
    full_adder fa24 (c12,p2[3],p3[2],s24,c24);

//third stage

    assign a={1'b0,p3[3],s24,s23,s22,s21,p1[0],p0[0]};
    assign b={1'b0,c24,c23,c22,c21,p2[0],p0[1],1'b0};
    
    CLA8Top cla(a,b,1'b0,sum,cout);
    assign prod[0] = sum[0]; 
    assign prod[1] = sum[1]; 
    assign prod[2] = sum[2]; 
    assign prod[3] = sum[3]; 
    assign prod[4] = sum[4]; 
    assign prod[5] = sum[5]; 
    assign prod[6] = sum[6]; 
    assign prod[7] = sum[7];
    assign co=cout;

endmodule

module CLA8Top(ain, bin, cin, sum, cout);

    input [7:0] ain, bin;
    input cin;
    output [7:0] sum;
    output cout;
    wire C; 

    claAdder C1(ain[3:0], bin[3:0], cin, sum[3:0], C);
    claAdder C2(ain[7:4], bin[7:4], C, sum[7:4], cout);
endmodule

module half_adder(a,b,sum,carry);
    input a,b;
    output sum,carry;

    assign sum= a^b;
    assign carry= a&&b;
endmodule

module full_adder(a,b,cin,sum, carry);
    input a,b,cin;
    output sum,carry;

    assign sum= a^b^cin;
    assign carry= (a&&b)||(cin&&(a^b));
endmodule

module tb;

    reg [3:0] A;
    reg [3:0] B;

    wire [7:0]prod;
    wire co;

    wallace w1 (A,B,prod,co);

    initial begin
        A = 4'd5;
        B = 4'd9;
    end

    initial 
       $monitor("a=%b b=%b prod=%d ",A,B,prod);

endmodule