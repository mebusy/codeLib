


%{
#include "ch3hdr.h"   
#include <stdio.h>		
void yyerror(char *s) ;

double vbltable [26] ;   
%}


%union {				 
	double dval;
	/*int vblno;*/
	struct symtab *symp;	 
}

%token <symp> NAME  
%token <dval>	NUMBER
%left '-' '+'
%left '*' '/'
%nonassoc UMINUS

%type <dval> expression		 

%%

	
statement_list:	statement '\n'		 
		| 		statement_list statement '\n'
		;

statement: 	NAME '=' expression		{ $1->value = $3; }    
		|	expression	{ printf("= %g\n" , $1); }
		;

expression:	expression '+' expression	{ $$ = $1 + $3; }
		|	expression '-' expression	{ $$ = $1 - $3; }
		|	expression '*' expression	{ $$ = $1 * $3; }
		|	expression '/' expression	{ if ($3==0.0)		  
										yyerror("divide by 0");
									  else
									  	$$ = $1 / $3; 
									}
		|	'-' expression	%prec UMINUS		{ $$ = -$2; }
		|	'(' expression	')'		{ $$ = $2; }
		|	NUMBER					{ $$ = $1; }
		|	NAME					{ $$ = $1->value; }	   
		|   NAME '(' expression	')'	{ $$ = ($1->funcptr)($3); }  /* 3 */
		;

%%

	/* needed for MacOSX */
void yyerror(char *s) {
    fprintf(stdout, "%s\n", s);
}

int main(void) {
	extern double sqrt() , exp(), log();  /* 1 */
	addfunc("sqrt" , sqrt) ;
	addfunc("exp" , exp) ;
	addfunc("log" , log) ;

    yyparse();
	return 0; 
}


	/* 2 */
addfunc( name , func )
char* name ;
double (*func)() ; 
{
	struct symtab * sp = symlook(name);
	sp->funcptr = func ;
}

/* look up a symbol table entry, add if not present */ 
struct symtab * symlook(s)
char *s;
{
	char *p; 
	struct symtab *sp;

	for(sp = symtab; sp < &symtab[NSYMS]; sp++) { 
		/* is it already here? */
		if(sp->name && ! strcmp(sp->name, s))
			return sp;

		/* is it free */ 
		if(!sp->name) {
			sp->name = strdup(s); 
			return sp;
		}
		/* otherwise continue to next */
	}
	yyerror("Too many symbols");
	exit(1);   /* cannot continue */ 
	
} /* symlook */

