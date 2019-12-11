BASE = main
ARRAY = main_array
SRC = $(BASE).cpp
TARGET = $(BASE)
LL = $(BASE).ll
ASM = $(BASE).S
ifdef ARRAYS
ARARG = -D ARRAYOBJ
else
ARARG = 
endif
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
all: $(TARGET) $(ARRAY)

$(LL): $(SRC)
	clang++ -O2 -g $(SPLITARG) $^ -S -emit-llvm -o $@

$(ASM): $(LL)
	llc $< -o $@

$(ARRAY): $(SRC)
	g++ -O2 -g $(SPLITARG) -D ARRAYOBJ $^ $(LINK) -o $@


$(TARGET): $(ASM)
	gcc $^ -g $(SPLITARG) $(LINK) -o $@

clean:
	rm -f $(TARGET) $(ARRAY) $(LL) $(ASM) *~
