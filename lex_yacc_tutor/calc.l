
%{
#include "ch3hdr.h"   
#include "y.tab.h"
#include "math.h"
	/*extern int yylval ;*/
	/*extern double vbltable[26];*/		 
%}

%%

([0-9]+|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?)  	{ yylval.dval = atof(yytext); return NUMBER; }

[ \t]	;    /* ignore whitespace */

[A-Za-z][A-Za-z0-9]*	{struct symtab *sp = symlook(yytext) ; 
						 yylval.symp = sp ;
						 return NAME; }	

"$" 	{return 0;  /* logical EOF  end of input */}

\n		|
. 		return yytext[0] ;  /*very common catch-all */

%%

	/* needed for MacOSX */
int yywrap(void) {
	return 1 ;
}

