CC := gcc
LEX := flex
BISON := yacc

FLAG := -o
LEXFILE := flex.l
BISONFILE := parse.y

BISONOUT := y.tab.c

all: flex bison
	$(CC) src/$(BISONOUT) -o bin/main

flex:
	$(LEX) -o src/lex.yy.c $(LEXFILE)

bison:
	$(BISON) -d -o src/y.tab.c $(BISONFILE)

run:
	./bin/main > outfile
	cat outfile
	@echo "OUTFILE GENERATED"

clean:
	rm -f src/lex.yy.c src/y.tab.c src/y.tab.h bin/main outfile