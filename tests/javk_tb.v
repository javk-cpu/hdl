/*
 * javk_tb.v -- JAVK CPU (test bench)
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

`define CLK_TICKS 16


module javk_tb;


wire [7:0] databus;

reg clk;
reg rst;

wire [15:0] addrbus;
wire        rw;

javk uut(
	.databus(databus),

	.clk(clk),
	.rst(rst),

	.addrbus(addrbus),
	.rw(rw)
);

wire [7:0] dataread;
reg  [7:0] datawrite;

reg  [7:0] mem [65535:0];


assign databus  = rw ? 8'bz : datawrite;
assign dataread = rw ? databus : 8'bz;


assign datawrite = mem[addrbus];


integer rst_complete = 0;
initial
begin
	rst <= 1;
	#`CLK_TICKS;
	#`CLK_TICKS;
	#`CLK_TICKS;
	#`CLK_TICKS;
	rst <= 0;

	$display("RESET COMPLETE");
	rst_complete = 1;
end


always @(clk) if (rst_complete) $display("addrbus: 0x%4h rw: %1b databus: 0x%2h clk: %1b", addrbus, rw, databus, clk);


always
begin
	clk <= 0;
	#`CLK_TICKS;
	clk <= 1;
	#`CLK_TICKS;
end


endmodule
