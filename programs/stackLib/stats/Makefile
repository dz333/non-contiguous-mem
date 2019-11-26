BASE = stats
SRC = $(BASE).c
TARGET = $(BASE)
LL = $(BASE).ll
ASM = $(BASE).S
OBJ = $(BASE).o
MORESTACK = morestack
MORESRC = $(MORESTACK).S
MORESTACK_OBJ = $(MORESTACK).o

all: library

$(MORESTACK_OBJ) : $(MORESRC)
	gcc $^ -c -o $@

$(TARGET): $(SRC)
	gcc -O2 $^ -o $(TARGET)

$(ASM): $(SRC)
	gcc -O2 -S $^ -o $(ASM)

$(OBJ): $(SRC)
	gcc -O2 $^ -c -o $@

.PHONY: library

library: $(OBJ) $(MORESTACK_OBJ)
	ar rcs libstats.a $(OBJ) $(MORESTACK_OBJ)

.PHONY: clean
clean:
	rm -f $(TARGET) $(OBJ) $(LL) $(ASM) libstats.a *~
