BASE = recurse
SRC = $(BASE).cpp
TARGET = $(BASE)
LL = $(BASE).ll
ASM = $(BASE).S
ifdef SPLIT
SPLITARG = -fsplit-stack
endif

all: $(TARGET)

$(LL): $(SRC)
	clang++ -O2 $(SPLITARG) $^ -S -emit-llvm -o $@

$(ASM): $(LL)
	llc $< -o $@

$(TARGET): $(ASM)
	gcc $^ $(SPLITARG) -L../stackLib/stats -lstats -o $@

clean:
	rm -f $(TARGET) $(LL) $(ASM) *~
