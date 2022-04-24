/*
 * alu.v -- 8-bit arithmetic logic unit
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


module alu(
	input wire [7:0] a,
	input wire [7:0] b,
	input wire [2:0] op,
	input wire [2:0] shamt,
	input wire       clk,

	output reg [7:0] out,
	output reg [3:0] flags
);


always @(posedge clk)
begin
	case (op)
	`ALU_OP_ADD:
		out = a + b;
	`ALU_OP_SUB:
		out = a - b;
	`ALU_OP_NEG:
		out = ~b;
	`ALU_OP_AND:
		out = a & b;
	`ALU_OP_ORR:
		out = a | b;
	`ALU_OP_EOR:
		out = a ^ b;
	`ALU_OP_LSL:
		out = a << shamt;
	`ALU_OP_LSR:
		out = a >> shamt;
	default:
		out = a;
	endcase
end

endmodule
