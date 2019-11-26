BASE = stats
SRC = $(BASE).cpp
TARGET = $(BASE)
LL = $(BASE).ll
ASM = $(BASE).S
OBJ = $(BASE).o

all: library

$(TARGET): $(SRC)
	gcc -O2 $^ -o $(TARGET)

$(ASM): $(SRC)
	gcc -O2 -ffixed-r10 -S $^ -o $(ASM)

$(OBJ): $(SRC)
	gcc -O2 -ffixed-r10 $^ -c -o $@

.PHONY: library
library: $(OBJ)
	ar rcs libstats.a $(OBJ)

.PHONY: clean
clean:
	rm -f $(TARGET) $(OBJ) $(LL) $(ASM) libstats.a *~
