BASE = rb
SRC = main.cpp Red-Black-Tree/RBTree.cpp
TARGET = $(BASE)

GCCFLAGS=-std=c++11 -O2 -Wall


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

all: rb

$(TARGET): $(SRC)
	g++ $(GCCFLAGS) $(SPLITARG) $^ $(LINK) -o $@
clean:
	rm -f rb
