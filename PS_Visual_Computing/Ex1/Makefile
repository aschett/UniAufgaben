CXX = g++

CXXFLAGS = `pkg-config --cflags opencv4`

LDFLAGS = `pkg-config --libs opencv4`

TARGET = program

SRCS = ex_1_schett.cpp

OBJS = $(SRCS:.cpp=.o)

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) -o $(TARGET) $(OBJS) $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET)