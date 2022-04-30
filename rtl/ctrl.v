/*
 * ctrl.v -- controller unit
 * Copyright (C) 2022  Jacob Koziej <jacobkoziej@gmail.com>
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

`include "opcode.vh"


module ctrl(
	input wire [7:0] instr,
	input            clk,
	input            rst,

	output reg  [2:0] alu_op,
	output reg  [2:0] alu_shamt,
	output reg        alu_clk,
	output reg        fetch,
	output wire [3:0] reg_sel,
	output wire [1:0] reg16_src,
	output wire [1:0] reg16_dst
);


wire [3:0] opcode  = instr[7:4];
wire [3:0] operand = instr[3:0];


assign reg_sel   = operand;
assign reg16_src = operand[3:2];
assign reg16_dst = operand[1:0];


always @(negedge clk)
begin
	if (rst)
	begin
		fetch <= 1;
	end
end


assign alu_op    = opcode[2:0];
assign alu_shamt = operand[2:0];

always @(negedge clk) alu_clk <= 0;
always @(posedge clk) if (!opcode[`OPCODE_ARITHMETIC_BIT]) alu_clk <= 1;


endmodule
