SRC = hello.cpp
TARGET = hello
LL = hello.ll
ASM = hello.S
ifdef SPLIT
SPLITARG = -fsplit-stack
endif

all: $(TARGET)

$(TARGET): $(SRC)
	clang++ -O2 $(SPLITARG) $^ -o $@

$(LL): $(SRC)
	clang++ -O2 $(SPLITARG) $^ -S -emit-llvm -o $@

$(ASM): $(LL)
	llc $< -o $@

clean:
	rm -f $(TARGET) $(LL) $(ASM) *~
