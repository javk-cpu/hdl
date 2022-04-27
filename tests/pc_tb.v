/*
 * pc_tb.v -- program counter (test bench)
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

module pc_tb;


reg [15:0] addr;

reg ld;
reg clk;

wire [15:0] out;

pc uut(
	.addr(addr),
	.ld(ld),
	.clk(clk),

	.out(out)
);


initial
begin
	addr = 0;
	ld   = 1;
	#1;
	ld = 0;
	#1;

	$display("addr   | ld  | out");
	$display("-------+-----+-------");

	clk = 0;
	for (integer i = 0; i <= 'hf; i = i + 1)
	begin
		clk <= 1;
		#1;
		clk <= 0;
		#1;

		$display("0x%4h | 0b%1b | 0x%4h", addr, ld, out);
	end

	addr = 16'hffff;
	ld = 1;
	#1;

	$display("0x%4h | 0b%1b | 0x%4h", addr, ld, out);

	ld = 0;
	#1;

	clk <= 1;
	#1;
	clk <= 0;
	#1;

	$display("0x%4h | 0b%1b | 0x%4h", addr, ld, out);
end


endmodule
