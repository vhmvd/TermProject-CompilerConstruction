# SQL-PARSER

## Steps

1. Prerequisite is to have flex and yacc/bison installed.

2. Add query in the infile. Sample query is already present.

3. Use the `makefile` recipe to generate code and to run the code.

> `make` Generates code and binary.
>
>`make run` Runs the query present in infile and generates an outfile.
>
>`make clean` Deletes the outfile and files in src and bin.

