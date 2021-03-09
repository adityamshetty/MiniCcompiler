#!/bin/sh
lex lex_spec.l
yacc -d yacc_spec.y -v
gcc -w -g y.tab.c -ly -ll -o output
./output program.c
