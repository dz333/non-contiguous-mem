BASE = arrays
SRC = $(BASE).cpp
TARGET = $(BASE)
OBJ = $(BASE).o

all: library

$(TARGET): $(SRC)
	g++ -O1 -g -std=c++11 $^ -o $(TARGET)

$(OBJ): $(SRC)
	g++ -O1 -g -std=c++11 -fPIC $^ -o $(OBJ)

.PHONY: library

library: $(OBJ)
	ar rcs libarrays.a $(OBJ)

.PHONY: clean
clean:
	rm -f $(TARGET) $(OBJ) libarrays.a *~
