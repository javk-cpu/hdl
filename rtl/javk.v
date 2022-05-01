/*
 * javk.v -- JAVK CPU
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

reg [7:0]  regfile [15:0];
reg [15:0] pc;
reg [15:0] sp;

reg  [7:0] alu_reg;
wire [2:0] alu_op;
wire [2:0] alu_shamt;
wire [3:0] alu_flags;
wire       alu_clk;
reg  [7:0] alu_out;

alu alu_javk(
	.a(regfile[`REGFILE_A]),
	.b(alu_reg),
	.op(alu_op),
	.shamt(alu_shamt),
	.clk(alu_clk),

	.out(alu_out),
	.flags(alu_flags)
);

reg  [7:0] instr;
wire       fetch;
wire [3:0] nibble_out;
wire [3:0] reg_sel;
wire [1:0] reg16_src;
wire [1:0] reg16_dst;
wire       we;

ctrl ctrl_javk(
	.instr(instr),
	.clk(clk),

	.alu_op(alu_op),
	.alu_shamt(alu_shamt),
	.alu_clk(alu_clk),
	.fetch(fetch),
	.nibble_out(nibble_out),
	.reg_sel(reg_sel),
	.reg16_src(reg16_src),
	.reg16_dst(reg16_dst),
	.we(we)
);


always @(negedge clk) rw <= 0;
always @(posedge clk) rw <= we ? 1 : 0;
assign databus = rw ? dataout : 8'bz;
assign datain  = rw ? 8'bz : databus;


assign alu_reg = regfile[reg_sel];


always @(negedge clk)
begin
	if (rst)
	begin
		addrbus <= 0;
		rw      <= 0;

		dataout <= 0;

		regfile[`REGFILE_Z] <= 0;
		pc                  <= 0;
		sp                  <= 0;
	end
end


always @(negedge clk)
begin
	addrbus <= pc;
	#1;

	instr <= datain;
	#1;

	pc <= pc + 1;
end

always @(posedge clk)
begin
	if (fetch)
	begin
		addrbus <= {regfile[`REGFILE_I], regfile[`REGFILE_J]};
		#1;

		if (rw) dataout <= regfile[`REGFILE_A];
		else    regfile[`REGFILE_A] <= datain;
	end
end


always @(posedge clk) if (we) dataout <= regfile[`REGFILE_A];


endmodule
