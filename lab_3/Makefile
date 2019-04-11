BIN=./bin
BUILD=./build

$(BUILD)/%.o: %.s
	$(MKDIR_P) $(dir $@)
	as --gstabs+ --32 $< -o $@

COMMON=build/utils/macros.o

$(BIN)/%.out: $(BUILD)/%.o $(COMMON)
	$(MKDIR_P) $(dir $@)
	ld -melf_i386 -dynamic-linker /lib/i386-linux-gnu/ld-linux.so.2 $^  -o $@ -lc


MKDIR_P ?= mkdir -p 