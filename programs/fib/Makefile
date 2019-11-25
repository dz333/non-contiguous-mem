BASE = fib
SRC = $(BASE).cpp
TARGET = $(BASE)
LL = $(BASE).ll
ASM = $(BASE).S
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
