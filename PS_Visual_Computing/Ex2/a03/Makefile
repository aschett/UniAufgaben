# Define compiler and flags
CXX = g++
CXXFLAGS = -std=c++11 `pkg-config --cflags opencv4`
LDFLAGS = `pkg-config --libs opencv4`

# Target executable name
TARGET = exc03

# Source file
SRC = main.cpp

# Default target
all: $(TARGET)

# Compile and link
$(TARGET): $(SRC)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SRC) $(LDFLAGS)

# Clean up build files
clean:
	rm -f $(TARGET)
