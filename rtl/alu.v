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


`define FLAG_Z 3
`define FLAG_N 2
`define FLAG_C 1
`define FLAG_V 0


module alu(
	input wire [7:0] a,
	input wire [7:0] b,
	input wire [2:0] op,
	input wire [2:0] shamt,
	input wire       clk,

	output reg [7:0] out,
	output reg [3:0] flags
);


reg  [15:0] tmp_out;


always @(a or b or op or shamt)
begin
	case (op)
	`ALU_OP_ADD:
		tmp_out = a + b;
	`ALU_OP_SUB:
		tmp_out = a - b;
	`ALU_OP_NEG:
		tmp_out = ~b;
	`ALU_OP_AND:
		tmp_out = a & b;
	`ALU_OP_ORR:
		tmp_out = a | b;
	`ALU_OP_EOR:
		tmp_out = a ^ b;
	`ALU_OP_LSL:
		tmp_out = a << shamt;
	`ALU_OP_LSR:
		tmp_out = a >> shamt;
	default:
		tmp_out = 8'b0;
	endcase
end


always @(posedge clk)
begin
	out <= tmp_out;

	flags[`FLAG_Z] <= !tmp_out[7:0];
	flags[`FLAG_N] <= tmp_out[7];
	flags[`FLAG_C] <= tmp_out[8];
	flags[`FLAG_V] <= (tmp_out[15:8]) ? 1 : 0;
end


endmodule
