BASE = chase
ARRAY = chase_array
SRC = main.cpp
TARGET = $(BASE)
LL = main.ll
ASM = main.S

GCCFLAGS=-O0 -Wall

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
all: $(TARGET) $(ARRAY) scan scan_array scan_opt

$(LL): $(SRC)
	clang++ -O2 -g $(SPLITARG) $^ -S -emit-llvm -o $@

$(ASM): $(LL)
	llc $< -o $@

$(ARRAY): $(SRC)
	g++ $(GCCFLAGS) -g -D ARRAYOBJ $^ $(LINK) -o $@

$(TARGET): $(SRC)
	g++ $(GCCFLAGS) -g $^ $(LINK) -o $@

scan: $(SRC)
	g++ $(GCCFLAGS) -g -D SCAN $^ $(LINK) -o $@

scanll: $(SRC)
	clang++ -O2 -g -D SCAN $^ $(LINK) -o $@

scan.S: $(SRC)
	g++ $(GCCFLAGS) -g -S -D SCAN $^ $(LINK) -o $@

scan_array: $(SRC)
	g++ $(GCCFLAGS) -g -D ARRAYOBJ -D SCAN $^ $(LINK) -o $@

scan_opt: $(SRC)
	g++ $(GCCFLAGS) -g -D ARRAYOBJ -D SCAN -D OPT $^ $(LINK) -o $@

scan_optll: $(SRC)
	clang++ -O2 -g -D ARRAYOBJ -D SCAN -D OPT $^ $(LINK) -o $@

scan_opt.S: $(SRC)
	g++ $(GCCFLAGS) -g -S -D ARRAYOBJ -D SCAN -D OPT $^ $(LINK) -o $@

clean:
	rm -f $(TARGET) $(ARRAY) scan scan_array scan_opt $(LL) $(ASM) *~
