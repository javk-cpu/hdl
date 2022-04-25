/*
 * pc.v -- program counter
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

module pc(
	input wire [15:0] addr,
	input wire        ld,
	input wire        clk,

	output reg [15:0] out
);


always @(posedge ld)  out <= addr;
always @(posedge clk) out <= out + 1;


endmodule
