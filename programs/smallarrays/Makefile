BASE = chase
ARRAY = chase_array
SRC = main.cpp
TARGET = $(BASE)
LL = main.ll
ASM = main.S

GCCFLAGS=-std=c++11 -O2 -Wall -D DEBUG


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

all: chase chase_array scan scan_array scan_opt strided strided_array strided_opt

array: chase_array scan_array scan_opt strided_array

base: chase scan strided
$(LL): $(SRC)
	clang++ -O2 $(SPLITARG) $^ -S -emit-llvm -o $@

$(ASM): $(LL)
	llc $< -o $@

$(ARRAY): $(SRC)
	g++ $(GCCFLAGS) -D ARRAYOBJ $^ $(LINK) -o $@

$(TARGET): $(SRC)
	g++ $(GCCFLAGS) $^ $(LINK) -o $@

scan: $(SRC)
	g++ $(GCCFLAGS) -D SCAN $^ $(LINK) -o $@

scan.S: $(SRC)
	g++ $(GCCFLAGS) -S -D SCAN $^ $(LINK) -o $@

scan_array: $(SRC)
	g++ $(GCCFLAGS) -D ARRAYOBJ -D SCAN $^ $(LINK) -o $@

scan_array.S: $(SRC)
	g++ $(GCCFLAGS) -S -D ARRAYOBJ -D SCAN $^ $(LINK) -o $@

scan_opt: $(SRC)
	g++ $(GCCFLAGS) -D ARRAYOBJ -D SCAN -D OPT $^ $(LINK) -o $@

scan_opt.S: $(SRC)
	g++ $(GCCFLAGS) -S -D ARRAYOBJ -D SCAN -D OPT $^ $(LINK) -o $@

strided: $(SRC)
	g++ $(GCCFLAGS) -D STRIDE $^ $(LINK) -o $@

strided.S: $(SRC)
	g++ $(GCCFLAGS) -S -D STRIDE $^ $(LINK) -o $@

strided_array: $(SRC)
	g++ $(GCCFLAGS) -D ARRAYOBJ -D STRIDE $^ $(LINK) -o $@

strided_array.S: $(SRC)
	g++ $(GCCFLAGS) -S -D ARRAYOBJ -D STRIDE $^ $(LINK) -o $@

strided_opt: $(SRC)
	g++ $(GCCFLAGS) -D ARRAYOBJ -D STRIDE -D OPT $^ $(LINK) -o $@

clean:
	rm -f chase chase_array scan scan_array scan_opt strided strided_array strided_opt $(LL) $(ASM) *~
