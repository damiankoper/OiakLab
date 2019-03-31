BIN=./bin
BUILD=./build

$(BUILD)/%.o: %.s
	$(MKDIR_P) $(dir $@)
	as --gstabs+ --32 $< -o $@

COMMON=build/utils/exit.o build/utils/printStr.o build/utils/add.o build/utils/readStr.o build/utils/intHexToStr.o

$(BIN)/%.out: $(BUILD)/%.o $(COMMON)
	$(MKDIR_P) $(dir $@)
	ld -melf_i386 $^ -o $@


MKDIR_P ?= mkdir -p 