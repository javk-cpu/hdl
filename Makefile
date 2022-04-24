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


.PHONY: all
all: alu_tb


.PHONY: clean
clean:
	@rm -rvf $(BUILD)


.PHONY: alu
alu_tb: $(BUILD)/$(TESTS)/alu_tb


$(BUILD)/$(TESTS)/alu_tb: $(ALU_TB) $(ALU_SRC) $(BUILD)/$(TESTS)
	$(IVERILOG) $(IVERILOGFLAGS) -o $(BUILD)/$(TESTS)/alu_tb $(ALU_TB) $(ALU_SRC)


$(BUILD)/$(TESTS): $(BUILD)
	@mkdir $(BUILD)/$(TESTS)


$(BUILD):
	@mkdir $(BUILD)