/*
 * alu_tb.v -- 8-bit arithmetic logic unit (test bench)
 * Copyright (C) 2022  Jacob Koziej <jacobkoziej@gmail.com>
 * Copyright (C) 2022  Ani Vardanyan <ani.var.2003@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

`include "alu.vh"


module alu_tb;


reg [7:0] a;
reg [7:0] b;
reg [2:0] op;
reg [3:0] shamt;

reg clk;

wire [7:0] out;
wire [3:0] flags;

alu uut(
	.a(a),
	.b(b),
	.op(op),
	.shamt(shamt),
	.clk(clk),

	.out(out),
	.flags(flags)
);


initial
begin
	$display("a    | b    | op    | shamt | out  | zncv");
	$display("-----+------+-------+-------+------+--------");
	a     = 8'b0;
	b     = 8'b0;
	op    = `ALU_OP_ADD;  // TODO: finish testing other operations
	shamt = 3'b0;
	clk   = 0;


	for (integer i = 0; i <= 'hff; i = i + 1)
	begin
		for (integer j = 0; j <= 'hff; j = j + 1)
		begin
			a = i;
			b = j;
			clk <= 1;
			#1;
			clk <= 0;
			#1;
			$display("0x%2h | 0x%2h | 0b%3b | 0b%3b | 0x%2h | 0b%4b", a, b, op, shamt, out, flags);
		end
	end
end


endmodule
