OBJECTS = bin/main.o bin/nbasic.o bin/RegEx.o
TARGET = bin/nbasic

default: $(OBJECTS)
	g++ $(OBJECTS) -o $(TARGET)
	mv $(TARGET) ../../bin_osx
	rm -rf bin

bin/main.o: main.cpp nbasic.h
	g++ -c main.cpp -o bin/main.o

bin/nbasic.o: nbasic.cpp nbasic.h RegEx.h
	g++ -c nbasic.cpp -o bin/nbasic.o

bin/RegEx.o: RegEx.cpp RegEx.h
	g++ -c RegEx.cpp -o bin/RegEx.o

clean:
	rm $(TARGET) $(OBJECTS)
