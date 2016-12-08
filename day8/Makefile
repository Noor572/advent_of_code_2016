.PHONY: grammar

all: grammar
	nitc day8.nit
	./day8 input.txt

grammar:
	nitcc pixelz.sablecc

clean:
	- rm *.out
	- rm *.dot
	- rm two_factor*.nit
	- rm day8
