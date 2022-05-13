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

`include "flag.vh"
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
wire [3:0] alu_shamt;
wire [3:0] alu_flags;
wire       alu_clk;
wire [7:0] alu_out;

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
wire [3:0] addr_offset;
wire       branch;
wire       fetch;
wire       jmp;
wire       jpl;
wire       mva;
wire       mvb;
wire       nibble_hl;
wire [3:0] nibble_out;
wire       nibble_read;
wire [3:0] reg_sel;
wire [1:0] reg16_src;
wire [1:0] reg16_dst;
wire       we;

ctrl ctrl_javk(
	.alu_flags(alu_flags),
	.instr(instr),
	.clk(clk),

	.addr_offset(addr_offset),
	.alu_op(alu_op),
	.alu_shamt(alu_shamt),
	.alu_clk(alu_clk),
	.branch(branch),
	.fetch(fetch),
	.jmp(jmp),
	.jpl(jpl),
	.mva(mva),
	.mvb(mvb),
	.nibble_hl(nibble_hl),
	.nibble_out(nibble_out),
	.nibble_read(nibble_read),
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
always @(alu_clk) #1 regfile[`REGFILE_A] <= alu_out;


always @(negedge clk)
begin
	if (rst)
	begin
		addrbus <= 0;
		rw      <= 0;

		dataout <= 0;

		regfile[`REGFILE_F] <= 0;
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
		addrbus <= {regfile[`REGFILE_I], regfile[`REGFILE_J]} + addr_offset;
		#1;

		if (rw) dataout <= regfile[`REGFILE_A];
		else    regfile[`REGFILE_A] <= datain;
	end
end


always @(posedge clk) if (jmp && branch) pc <= {regfile[`REGFILE_I], regfile[`REGFILE_J]};
always @(posedge clk)
begin
	if (jpl && branch)
	begin
		if (!regfile[`REGFILE_F][`FLAG_RET])
		begin
			regfile[`REGFILE_K] <= pc[15:8];
			regfile[`REGFILE_L] <= pc[7:0];
		end

		pc <= {regfile[`REGFILE_I], regfile[`REGFILE_J]};
		sp <= regfile[`REGFILE_F][`FLAG_RET] ? sp + 16 : sp - 16;

		regfile[`REGFILE_F][`FLAG_RET] <= 0;

		#1;
		regfile[`REGFILE_I] <= sp[15:8];
		regfile[`REGFILE_J] <= sp[7:0];
	end
end


always @(posedge clk)
begin
	if (mva)
	begin
		if ((reg_sel != `REGFILE_A) && (reg_sel != `REGFILE_Z))
		begin
			regfile[reg_sel] <= regfile[`REGFILE_A];
		end
	end
end

always @(posedge clk)
begin
	if (mvb)
	begin
		case (reg16_dst)
		`REGFILE_PC:
			case (reg16_src)
			`REGFILE_PC:
				pc <= pc;
			`REGFILE_SP:
				pc <= sp;
			`REGFILE_IJ:
				pc <= {regfile[`REGFILE_I], regfile[`REGFILE_J]};
			`REGFILE_KL:
				pc <= {regfile[`REGFILE_K], regfile[`REGFILE_L]};
			endcase
		`REGFILE_SP:
			case (reg16_src)
			`REGFILE_PC:
				sp <= pc;
			`REGFILE_SP:
				sp <= sp;
			`REGFILE_IJ:
				sp <= {regfile[`REGFILE_I], regfile[`REGFILE_J]};
			`REGFILE_KL:
				sp <= {regfile[`REGFILE_K], regfile[`REGFILE_L]};
			endcase
		`REGFILE_IJ:
			case (reg16_src)
			`REGFILE_PC:
			begin
				regfile[`REGFILE_I] <= pc[15:8];
				regfile[`REGFILE_J] <= pc[7:0];
			end
			`REGFILE_SP:
			begin
				regfile[`REGFILE_I] <= sp[15:8];
				regfile[`REGFILE_J] <= sp[7:0];
			end
			`REGFILE_IJ:
			begin
				regfile[`REGFILE_I] <= regfile[`REGFILE_I];
				regfile[`REGFILE_J] <= regfile[`REGFILE_J];
			end
			`REGFILE_KL:
			begin
				regfile[`REGFILE_I] <= regfile[`REGFILE_K];
				regfile[`REGFILE_J] <= regfile[`REGFILE_L];
			end
			endcase
		`REGFILE_KL:
			case (reg16_src)
			`REGFILE_PC:
			begin
				regfile[`REGFILE_K] <= pc[15:8];
				regfile[`REGFILE_L] <= pc[7:0];
			end
			`REGFILE_SP:
			begin
				regfile[`REGFILE_K] <= sp[15:8];
				regfile[`REGFILE_L] <= sp[7:0];
			end
			`REGFILE_IJ:
			begin
				regfile[`REGFILE_K] <= regfile[`REGFILE_I];
				regfile[`REGFILE_L] <= regfile[`REGFILE_J];
			end
			`REGFILE_KL:
			begin
				regfile[`REGFILE_K] <= regfile[`REGFILE_K];
				regfile[`REGFILE_L] <= regfile[`REGFILE_L];
			end
			endcase
		endcase
	end
end


always @(posedge clk)
begin
	if (nibble_read)
	begin
		if (nibble_hl) regfile[`REGFILE_A][7:4] <= nibble_out;
		else           regfile[`REGFILE_A][3:0] <= nibble_out;
	end
end


endmodule
