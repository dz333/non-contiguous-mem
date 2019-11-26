BASE = arrays
SRC = $(BASE).cpp
TARGET = $(BASE)
OBJ = $(BASE).o

all: $(TARGET)

$(TARGET): $(SRC)
	gcc $^ -o $(TARGET)

$(OBJ): $(SRC)
	gcc -c -fPIC $^ -o $(OBJ)
clean:
	rm -f $(TARGET) $(OBJ) *~
