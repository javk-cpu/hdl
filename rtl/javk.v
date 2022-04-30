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

`include "regfile.vh"


module javk(
	inout wire [7:0] databus,

	input wire clk,
	input wire rst,

	output reg [15:0] addrbus,
	output reg        rw
);


wire [7:0] datain;
reg  [7:0] dataout;
reg        we;

reg [7:0]  regfile [15:0];
reg [15:0] pc;
reg [15:0] sp;

reg  [7:0] instr;
wire       fetch;

ctrl ctrl_javk(
	.instr(instr),
	.clk(clk),
	.rst(rst),

	.fetch(fetch)
);


always @(negedge clk) rw <= 0;
always @(posedge clk) rw <= we ? 1 : 0;
assign databus = rw ? dataout : 8'bz;
assign datain  = rw ? 8'bz : databus;


assign regfile[`REGFILE_Z] = 8'b0;


always @(negedge clk)
begin
	if (rst)
	begin
		addrbus <= 0;
		rw      <= 0;

		dataout <= 0;
		we      <= 0;

		pc <= 0;
		sp <= 0;
	end
end


always @(negedge clk)
begin
	if (fetch)
	begin
		addrbus <= pc;
		#1;

		instr <= datain;
		#1;

		pc <= pc + 1;
	end
end


endmodule
