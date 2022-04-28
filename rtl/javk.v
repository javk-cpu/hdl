/*
 * javk.v -- JAVK CPU
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

module javk(
	inout wire [7:0] databus,

	input wire clk,
	input wire rst,

	output reg  [15:0] addrbus,
	output wire        rw
);


// 8-bit registers
reg [7:0] a;
reg [7:0] flags;
reg [7:0] b;
reg [7:0] c;
reg [7:0] d;
reg [7:0] e;
reg [7:0] g;
reg [7:0] h;
reg [7:0] i;
reg [7:0] j;
reg [7:0] k;
reg [7:0] l;
reg [7:0] m;
reg [7:0] n;
reg [7:0] o;


endmodule
