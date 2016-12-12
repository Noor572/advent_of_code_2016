all:
	mkdir -p bin
	nitcc balance.sablecc
	nitc execution.nit -o bin/execution
	./bin/execution input.txt

clean:
	- rm *.dot
	- rm *.out
	- rm *balance*nit*
	- rm -rf bin
