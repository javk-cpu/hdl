/*
 * flag.vh -- JAVK flags
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

`ifndef JAVK_HDL_FLAG
`define JAVK_HDL_FLAG


`define FLAG_EQ 4'b0000
`define FLAG_NE 4'b0001
`define FLAG_HS 4'b0010
`define FLAG_LO 4'b0011
`define FLAG_MI 4'b0100
`define FLAG_PL 4'b0101
`define FLAG_VS 4'b0110
`define FLAG_VC 4'b0111
`define FLAG_HI 4'b1000
`define FLAG_LS 4'b1001
`define FLAG_GE 4'b1010
`define FLAG_LT 4'b1011
`define FLAG_GT 4'b1100
`define FLAG_LE 4'b1101
`define FLAG_AL 4'b1110
`define FLAG_NV 4'b1111


`endif /* JAVK_HDL_FLAG */
