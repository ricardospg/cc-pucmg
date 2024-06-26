/*
806454
Ricardo Soares Cerqueira
*/ 

// Meio somador
module halfAdder (
	input a, b,
	output sum, carry
);
	xor XOR1 ( sum, a, b );
	and AND1 ( carry, a, b );
endmodule

// Somador completo usando meio somador
module fullAdder(
	input a, b, cin,
	output sum, carry
);
	wire c, c1, s;
	halfAdder HA0(a, b, s, c);
	halfAdder HA1(cin, s, sum, c1);
	assign carry = c | c1 ;
endmodule

module fiveBitAdder(
	input [4:0] a, b,
	output [4:0] sum,
	output carry
);
	wire c1, c2, c3, c4;

	fullAdder FA0(a[0], b[0], 1'b0, sum[0], c1);
	fullAdder FA1(a[1], b[1], c1, sum[1], c2);
	fullAdder FA2(a[2], b[2], c2, sum[2], c3);
	fullAdder FA3(a[3], b[3], c3, sum[3], c4);
	fullAdder FA4(a[4], b[4], c4, sum[4], carry);
endmodule

module Guia_0801_test;
	reg [4:0] a, b;
	wire [4:0] sum;
	wire carry;

	fiveBitAdder uut(a, b, sum, carry);

	initial begin
		$display("Guia_0801 - Ricardo Soares Cerqueira - 803833\n");
		
		$monitor("%b + %b = %b carry = %b\n", a, b, sum, carry);
		a = 5'b00011; b = 5'b00011;
		#1;
		a = 5'b00001; b = 5'b00001;
		#1;
		a = 5'b00010; b = 5'b00010;
		#1;
		a = 5'b00100; b = 5'b00100;
		#1;
		a = 5'b01000; b = 5'b01000;
		#1;
		a = 5'b10000; b = 5'b10000;
		#1;
		$finish();
	end
endmodule

/*
Saida esperada:
Guia_0801 - Ricardo Soares Cerqueira - 803833

00011 + 00011 = 00110 
carry = 0

00001 + 00001 = 00010 
carry = 0

00010 + 00010 = 00100 
carry = 0

00100 + 00100 = 01000 
carry = 0

01000 + 01000 = 10000 
carry = 0

10000 + 10000 = 00000 
carry = 1

*/
