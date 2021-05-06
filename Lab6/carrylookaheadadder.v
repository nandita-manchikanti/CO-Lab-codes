// iverilog carrylookaheadadder.v 
// ./a.out
`timescale 1ns/1ps
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

module CLA_test;
    reg[3:0] a;
    reg[3:0] b;
    reg cin;

    wire [3:0]sum;
    wire cout;

    claAdder func(a,b,cin,sum,cout);

    initial begin
        #0   a=4'b0000;b=4'b0000;cin=0;
		#10  a=4'b0000;b=4'b0000;cin=1;
		#10  a=4'b0000;b=4'b1111;cin=0;
		#10  a=4'b0000;b=4'b1111;cin=1; 
    end
    
    initial begin
		$monitor("%d: a=%b b=%b cin=%b sum=%b cout=%b",$time,a,b,cin,sum,cout);
	end

endmodule
