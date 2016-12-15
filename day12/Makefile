all:
	mkdir -p bin
	nitcc asembunny.sablecc
	nitc day12.nit -o bin/day12
	./bin/day12 input.txt

clean:
	- rm *parser*
	- rm *lexer*
	- rm *.dot
	- rm *.out
	- rm -rf bin
