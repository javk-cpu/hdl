/*
 * regfile.vh -- register file
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

`ifndef JAVK_HDL_REGFILE
`define JAVK_HDL_REGFILE


`define REGFILE_A 4'b0000
`define REGFILE_B 4'b0001
`define REGFILE_C 4'b0010
`define REGFILE_D 4'b0011
`define REGFILE_E 4'b0100
`define REGFILE_F 4'b0101
`define REGFILE_G 4'b0110
`define REGFILE_H 4'b0111
`define REGFILE_I 4'b1000
`define REGFILE_J 4'b1001
`define REGFILE_K 4'b1010
`define REGFILE_L 4'b1011
`define REGFILE_M 4'b1100
`define REGFILE_N 4'b1101
`define REGFILE_O 4'b1110
`define REGFILE_Z 4'b1111

`define REGFILE_PC 2'b00
`define REGFILE_SP 2'b01
`define REGFILE_IJ 2'b10
`define REGFILE_KL 2'b11


`endif /* JAVK_HDL_REGFILE */
