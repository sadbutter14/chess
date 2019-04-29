
CFLAGS = -Wall -Werror -std=c++11
OBJ = g++ $(CFLAGS) -c $< -o $@

.PHONY: clean

all:folder folder2 bin/chess.exe bin/test

folder:
	mkdir -p build 

folder2:
	mkdir -p bin 

bin/chess.exe: build/main.o build/board_print_plain.o build/board.o 
	g++ $(CFLAGS) $^ -o $@

build/main.o: src/main.cpp src/board.h 
	$(OBJ)

build/board_print_plain.o: src/board_print_plain.cpp src/board.h
	$(OBJ)

build/board.o: src/board.cpp src/board.h
	$(OBJ)

build/test.o: test/test.c
	gcc -Wall -std=c99 -c test/test.c -o build/test.o -Ithirdparty -Isrc

bin/test: build/test.o
	g++ -Wall -Werror -std=c++11 build/test.o -o bin/test

build/first_test.o: test/first_test.c
	gcc -Wall -std=c99 -c test/first_test.c -o build/first_test.o -Ithirdparty

bin/test: build/test.o  build/first_test.o 
	gcc -Wall -std=c99   build/test.o build/first_test.o -o bin/test

clean:
	rm build/*.o
	rm bin/*.exe
	rm -R build
	rm -R bin



