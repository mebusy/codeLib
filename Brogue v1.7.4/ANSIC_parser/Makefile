all: test


lex: 
	lex ansic.l	

yacc: lex
	yacc -d ansic2.y

cc: yacc
	rm -f ./a.out
	clang -g lex.yy.c y.tab.c lconvert.c 

test: cc
	./a.out < test.txt


