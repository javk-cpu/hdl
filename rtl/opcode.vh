/*
 * opcode.vh -- opcode definitions
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

`ifndef JAVK_HDL_OPCODE
`define JAVK_HDL_OPCODE


`define OPCODE_ADD 4'b0000  // add
`define OPCODE_SUB 4'b0001  // subtract
`define OPCODE_NEG 4'b0010  // negate
`define OPCODE_AND 4'b0011  // and
`define OPCODE_ORR 4'b0100  // inclusive or
`define OPCODE_EOR 4'b0101  // exclusive or
`define OPCODE_LSL 4'b0110  // logical shift left
`define OPCODE_LSR 4'b0111  // logical shift right
`define OPCODE_MVA 4'b1000  // move 'a' register
`define OPCODE_MVB 4'b1001  // move 16-bit register
`define OPCODE_LNL 4'b1010  // load nibble low
`define OPCODE_LNH 4'b1011  // load nibble high
`define OPCODE_LDB 4'b1100  // load byte
`define OPCODE_STB 4'b1101  // store byte
`define OPCODE_JMP 4'b1110  // jump
`define OPCODE_JPL 4'b1111  // jump (with link)

`define OPCODE_ARITHMETIC_BIT 3


`endif /* JAVK_HDL_OPCODE */
