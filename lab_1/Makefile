BIN=./bin
BUILD=./build

$(BUILD)/%.o: %.s
	$(MKDIR_P) $(dir $@)
	as --gstabs+ --32 $< -o $@


$(BIN)/%.out: $(BUILD)/%.o
	$(MKDIR_P) $(dir $@)
	ld -melf_i386 $^ -o $@


MKDIR_P ?= mkdir -p