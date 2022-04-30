# Copyright (C) 2022  Jacob Koziej <jacobkoziej@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

BUILD ?= build
RTL    = rtl
TESTS  = tests


IVERILOG      ?= iverilog
IVERILOGFLAGS += -I$(RTL) -Wall -g2012


ALU_SRC = $(RTL)/alu.v
ALU_TB  = $(TESTS)/alu_tb.v

CTRL_SRC = $(RTL)/ctrl.v
CTRL_TB  = $(TESTS)/ctrl_tb.v

JAVK_SRC = $(RTL)/javk.v $(CTRL_SRC)
JAVK_TB  = $(TESTS)/javk_tb.v

PC_SRC = $(RTL)/pc.v
PC_TB  = $(TESTS)/pc_tb.v


.PHONY: all
all: alu_tb ctrl_tb javk_tb pc_tb


.PHONY: clean
clean:
	@rm -rvf $(BUILD)


.PHONY: alu_tb
alu_tb: $(BUILD)/$(TESTS)/alu_tb


.PHONY: ctrl_tb
ctrl_tb: $(BUILD)/$(TESTS)/ctrl_tb


.PHONY: javk_tb
javk_tb: $(BUILD)/$(TESTS)/javk_tb


.PHONY: pc_tb
pc_tb: $(BUILD)/$(TESTS)/pc_tb


$(BUILD)/$(TESTS)/alu_tb: $(ALU_TB) $(ALU_SRC) $(BUILD)/$(TESTS)
	$(IVERILOG) $(IVERILOGFLAGS) -o $(BUILD)/$(TESTS)/alu_tb $(ALU_TB) $(ALU_SRC)


$(BUILD)/$(TESTS)/ctrl_tb: $(CTRL_TB) $(CTRL_SRC) $(BUILD)/$(TESTS)
	$(IVERILOG) $(IVERILOGFLAGS) -o $(BUILD)/$(TESTS)/ctrl_tb $(CTRL_TB) $(CTRL_SRC)


$(BUILD)/$(TESTS)/javk_tb: $(JAVK_TB) $(JAVK_SRC) $(BUILD)/$(TESTS)
	$(IVERILOG) $(IVERILOGFLAGS) -o $(BUILD)/$(TESTS)/javk_tb $(JAVK_TB) $(JAVK_SRC)


$(BUILD)/$(TESTS)/pc_tb: $(PC_TB) $(PC_SRC) $(BUILD)/$(TESTS)
	$(IVERILOG) $(IVERILOGFLAGS) -o $(BUILD)/$(TESTS)/pc_tb $(PC_TB) $(PC_SRC)


$(BUILD)/$(TESTS): $(BUILD)
	@mkdir $(BUILD)/$(TESTS)


$(BUILD):
	@mkdir $(BUILD)
