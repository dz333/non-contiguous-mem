BASE = arrays
SRC = $(BASE).cpp
TARGET = $(BASE)
OBJ = $(BASE).o

all: library

$(TARGET): $(SRC)
	g++ -O2 -g $^ -o $(TARGET)

$(OBJ): $(SRC)
	g++ -O2 -c -fPIC $^ -o $(OBJ)

.PHONY: library

library: $(OBJ)
	ar rcs libarrays.a $(OBJ)

.PHONY: clean
clean:
	rm -f $(TARGET) $(OBJ) libarrays.a *~
