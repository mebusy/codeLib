// Define a grammar
grammar Expr;

// asuume our lange can only input 1 expression
// so our program is only 1 statement
prog: stat
;
// the statement is consist of expression and NEWLINE
stat: expr
     |NEWLINE
;

// define arithmetic priority
expr : multExpr (('+'|'-') multExpr)*
;
multExpr : atom (('*'|'/') atom)*
;
atom:  '(' expr ')'   # AAA
      | INT           # BBB
      | ID            # CCC
;

// the Lexical
ID : ('a'..'z' |'A'..'Z')+ ; 
INT : '0'..'9' + ; 
NEWLINE:'\r' ? '\n' ; 
WS : (' ' |'\t' |'\n' |'\r' )+ {skip();} ;



