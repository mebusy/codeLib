all: test


lex: 
	lex ansic_new.l	

yacc: lex
	yacc -d ansic_new.y

cc: yacc
	rm -f ./a.out
	clang lex.yy.c y.tab.c  

test: cc
	./a.out < test.txt
