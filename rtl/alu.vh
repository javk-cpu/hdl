/*
 * alu.vh -- 8-bit arithmetic logic unit
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

`ifndef JAVK_HDL_ALU
`define JAVK_HDL_ALU


`define ALU_OP_ADD 3'b000
`define ALU_OP_SUB 3'b001
`define ALU_OP_NEG 3'b010
`define ALU_OP_AND 3'b011
`define ALU_OP_ORR 3'b100
`define ALU_OP_EOR 3'b101
`define ALU_OP_LSL 3'b110
`define ALU_OP_LSR 3'b111

`define ALU_FLAG_Z 4'b1000
`define ALU_FLAG_N 4'b0100
`define ALU_FLAG_C 4'b0010
`define ALU_FLAG_V 4'b0001


`endif /* JAVK_HDL_ALU */
