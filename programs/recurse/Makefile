BASE = recurse
SRC = $(BASE).cpp
TARGET = $(BASE)
LL = $(BASE).ll
ASM = $(BASE).S
ifdef SPLIT
SPLITARG = -fsplit-stack
else
SPLITARG =
endif
ifdef INST
LINK = -L../stackLib/stats -lstats
else
LINK =
endif
all: $(TARGET)

$(LL): $(SRC)
	clang++ -O1 $(SPLITARG) $^ -S -emit-llvm -o $@

$(ASM): $(LL)
	llc $< -o $@

$(TARGET): $(ASM)
	gcc $^ $(SPLITARG) $(LINK) -o $@

clean:
	rm -f $(TARGET) $(LL) $(ASM) *~
