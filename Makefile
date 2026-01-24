# Directories
SRC_DIR  := src
TB_DIR   := tb
OUT_DIR  := out
VCD_FILE = $(OUT_DIR)/waveform.vcd

# Files
# We find the top-level testbench specifically, and iverilog 
# can often find the dependencies if they are in the include path.
SRCS     := $(wildcard $(SRC_DIR)/*.sv) $(wildcard $(TB_DIR)/*.sv)
TARGET   := $(OUT_DIR)/rv32_simulation.vvp

# Compiler and Flags
# -g2012 enables SystemVerilog support
IVE      := iverilog
FLAGS    := -g2012 -Wall -I$(SRC_DIR) -I$(TB_DIR)
VVP      := vvp

# Default target: Compile and Run
all: $(TARGET)
	@echo "Running simulation..."
	$(VVP) $(TARGET)

# Compilation Rule
# Icarus Verilog prefers taking all source files at once
$(TARGET): $(SRCS) | $(OUT_DIR)
	$(IVE) $(FLAGS) -o $(TARGET) $(SRCS)

# Create output directory
$(OUT_DIR):
	mkdir -p $(OUT_DIR)

clean:
	rm -rf $(OUT_DIR)

# Rule to open GTKWave
wave:
	gtkwave $(VCD_FILE) &

.PHONY: all clean