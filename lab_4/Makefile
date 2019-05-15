BIN=./bin
BUILD=./build

$(BUILD)/%.o: %.s
	$(MKDIR_P) $(dir $@)
	as -g --32 $< -o $@

$(BUILD)/%.o: %.c
	$(MKDIR_P) $(dir $@)
	gcc -c -g -m32 $< -o $@

$(BIN)/my_sinDemo.out: $(BUILD)/my_sin.o $(BUILD)/my_sinDemo.o
	$(MKDIR_P) $(dir $@)
	gcc -g -m32 $^ -o $@ 

$(BIN)/%.out: $(BUILD)/%.o $(COMMON)
	$(MKDIR_P) $(dir $@)
	ld -melf_i386 -dynamic-linker /lib/i386-linux-gnu/ld-linux.so.2 $^  -o $@ -lc

MKDIR_P ?= mkdir -p 