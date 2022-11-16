%{
#include <stdio.h>
#include <string.h>
#include "lconvert.h"

extern int yyerror(char* s) ;
int yylex(void);
extern void exit(int status) ;

%}

%union {    
    char* text ;
}

%token IDENTIFIER CONSTANT STRING_LITERAL SIZEOF
%type <text> IDENTIFIER CONSTANT STRING_LITERAL SIZEOF
%token PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%type <text> PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
%type <text> AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
%token SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%type <text> SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%token XOR_ASSIGN OR_ASSIGN TYPE_NAME
%type <text> XOR_ASSIGN OR_ASSIGN TYPE_NAME

%token TYPEDEF EXTERN STATIC AUTO REGISTER
%type <text> TYPEDEF EXTERN STATIC AUTO REGISTER
%token CHAR BOOL SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID
%type <text> CHAR BOOL SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID
%token STRUCT UNION ENUM ELLIPSIS
%type <text> STRUCT UNION ENUM ELLIPSIS

%token CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN
%type <text> CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN


%type <text>  primary_expression postfix_expression argument_expression_list unary_expression unary_operator cast_expression multiplicative_expression additive_expression shift_expression relational_expression equality_expression and_expression exclusive_or_expression inclusive_or_expression logical_and_expression logical_or_expression conditional_expression assignment_expression assignment_operator expression constant_expression declaration declaration_specifiers init_declarator_list init_declarator storage_class_specifier type_specifier struct_or_union_specifier struct_or_union struct_declaration_list struct_declaration specifier_qualifier_list struct_declarator_list struct_declarator enum_specifier enumerator_list enumerator type_qualifier declarator direct_declarator pointer type_qualifier_list parameter_type_list parameter_list parameter_declaration identifier_list type_name abstract_declarator direct_abstract_declarator initializer initializer_list statement labeled_statement compound_statement declaration_list statement_list expression_statement selection_statement iteration_statement jump_statement translation_unit external_declaration function_definition


%start translation_unit
%%

primary_expression
	: IDENTIFIER		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| CONSTANT		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| STRING_LITERAL		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| '(' expression ')'		{ stringncatAndAssignment ( &$$ , "(", $2, ")",  0 );   }  
	;

postfix_expression
	: primary_expression		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| postfix_expression '[' expression ']'		{ stringncatAndAssignment ( &$$ , $1, "[", $3, "]",  0 );   yyerror( "TODO" ); }  
	| postfix_expression '(' ')'		{ stringncatAndAssignment ( &$$ , $1, "(", ")",  0 );   }  
	| postfix_expression '(' argument_expression_list ')'		{ stringncatAndAssignment ( &$$ , $1, "(", $3, ")",  0 );   }  
	| postfix_expression '.' IDENTIFIER		{ stringncatAndAssignment ( &$$ , $1, ".", $3,  0 );   }  
	| postfix_expression PTR_OP IDENTIFIER		{ stringncatAndAssignment ( &$$ , $1, $2, $3,  0 );   }  
	| postfix_expression INC_OP		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	| postfix_expression DEC_OP		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	;

argument_expression_list
	: assignment_expression		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| argument_expression_list ',' assignment_expression		{ stringncatAndAssignment ( &$$ , $1, ",", $3,  0 );   }  
	;

unary_expression
	: postfix_expression		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| INC_OP unary_expression		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	| DEC_OP unary_expression		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	| unary_operator cast_expression		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	| SIZEOF unary_expression		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	| SIZEOF '(' type_name ')'		{ stringncatAndAssignment ( &$$ , $1, "(", $3, ")",  0 );   }  
	;

unary_operator
	: '&'		{ stringncatAndAssignment ( &$$ , "&",  0 );   }  
	| '*'		{ stringncatAndAssignment ( &$$ , "*",  0 );   }  
	| '+'		{ stringncatAndAssignment ( &$$ , "+",  0 );   }  
	| '-'		{ stringncatAndAssignment ( &$$ , "-",  0 );   }  
	| '~'		{ stringncatAndAssignment ( &$$ , "~",  0 );   }  
	| '!'		{ stringncatAndAssignment ( &$$ , "!",  0 );   }  
	;

cast_expression
	: unary_expression		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| '(' type_name ')' cast_expression		{ stringncatAndAssignment ( &$$ , "(", $2, ")", $4,  0 );   }  
	;

multiplicative_expression
	: cast_expression		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| multiplicative_expression '*' cast_expression		{ stringncatAndAssignment ( &$$ , $1, "*", $3,  0 );   }  
	| multiplicative_expression '/' cast_expression		{ stringncatAndAssignment ( &$$ , $1, "/", $3,  0 );   }  
	| multiplicative_expression '%' cast_expression		{ stringncatAndAssignment ( &$$ , $1, "%", $3,  0 );   }  
	;

additive_expression
	: multiplicative_expression		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| additive_expression '+' multiplicative_expression		{ stringncatAndAssignment ( &$$ , $1, "+", $3,  0 );   }  
	| additive_expression '-' multiplicative_expression		{ stringncatAndAssignment ( &$$ , $1, "-", $3,  0 );   }  
	;

shift_expression
	: additive_expression		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| shift_expression LEFT_OP additive_expression		{ stringncatAndAssignment ( &$$ , $1, $2, $3,  0 );   }  
	| shift_expression RIGHT_OP additive_expression		{ stringncatAndAssignment ( &$$ , $1, $2, $3,  0 );   }  
	;

relational_expression
	: shift_expression		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| relational_expression '<' shift_expression		{ stringncatAndAssignment ( &$$ , $1, "<", $3,  0 );   }  
	| relational_expression '>' shift_expression		{ stringncatAndAssignment ( &$$ , $1, ">", $3,  0 );   }  
	| relational_expression LE_OP shift_expression		{ stringncatAndAssignment ( &$$ , $1, $2, $3,  0 );   }  
	| relational_expression GE_OP shift_expression		{ stringncatAndAssignment ( &$$ , $1, $2, $3,  0 );   }  
	;

equality_expression
	: relational_expression		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| equality_expression EQ_OP relational_expression		{ stringncatAndAssignment ( &$$ , $1, $2, $3,  0 );   }  
	| equality_expression NE_OP relational_expression		{ stringncatAndAssignment ( &$$ , $1, $2, $3,  0 );   }  
	;

and_expression
	: equality_expression		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| and_expression '&' equality_expression		{ stringncatAndAssignment ( &$$ , $1, "&", $3,  0 );   }  
	;

exclusive_or_expression
	: and_expression		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| exclusive_or_expression '^' and_expression		{ stringncatAndAssignment ( &$$ , $1, "^", $3,  0 );   }  
	;

inclusive_or_expression
	: exclusive_or_expression		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| inclusive_or_expression '|' exclusive_or_expression		{ stringncatAndAssignment ( &$$ , $1, "|", $3,  0 );   }  
	;

logical_and_expression
	: inclusive_or_expression		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| logical_and_expression AND_OP inclusive_or_expression		{ stringncatAndAssignment ( &$$ , $1, $2, $3,  0 );   }  
	;

logical_or_expression
	: logical_and_expression		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| logical_or_expression OR_OP logical_and_expression		{ stringncatAndAssignment ( &$$ , $1, $2, $3,  0 );   }  
	;

conditional_expression
	: logical_or_expression		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| logical_or_expression '?' expression ':' conditional_expression		{ stringncatAndAssignment ( &$$ , $1, "?", $3, ":", $5,  0 );   }  
	;

assignment_expression
	: conditional_expression		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| unary_expression assignment_operator assignment_expression		{ stringncatAndAssignment ( &$$ , $1, $2, $3,  0 );   }  
	;

assignment_operator
	: '='		{ stringncatAndAssignment ( &$$ , "=",  0 );   }  
	| MUL_ASSIGN		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| DIV_ASSIGN		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| MOD_ASSIGN		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| ADD_ASSIGN		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| SUB_ASSIGN		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| LEFT_ASSIGN		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| RIGHT_ASSIGN		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| AND_ASSIGN		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| XOR_ASSIGN		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| OR_ASSIGN		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	;

expression
	: assignment_expression		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| expression ',' assignment_expression		{ stringncatAndAssignment ( &$$ , $1, ",", $3,  0 );   }  
	;

constant_expression
	: conditional_expression		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	;

declaration
	: declaration_specifiers ';'		{ stringncatAndAssignment ( &$$ , $1, ";",  0 );   }  
	| declaration_specifiers init_declarator_list ';'		{ stringncatAndAssignment ( &$$ , $1, $2, ";",  0 );  }  
	;

declaration_specifiers
	: storage_class_specifier		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| storage_class_specifier declaration_specifiers		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	| type_specifier		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| type_specifier declaration_specifiers		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	| type_qualifier		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| type_qualifier declaration_specifiers		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	;

init_declarator_list
	: init_declarator		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| init_declarator_list ',' init_declarator		{ stringncatAndAssignment ( &$$ , $1, ",", $3,  0 );   }  
	;

init_declarator
	: declarator		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| declarator '=' initializer		{ stringncatAndAssignment ( &$$ , $1, "=", $3,  0 );   }  
	;

storage_class_specifier
	: TYPEDEF		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| EXTERN		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| STATIC		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| AUTO		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| REGISTER		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	;

type_specifier
	: VOID		{ stringncatAndAssignment ( &$$ , $1,  0 );  curVar.type = $1 ;   }  
	| CHAR		{ stringncatAndAssignment ( &$$ , $1,  0 );  curVar.type = $1 ;   }  
	| BOOL		{ stringncatAndAssignment ( &$$ , $1,  0 );  curVar.type = $1 ;   }  
	| SHORT		{ stringncatAndAssignment ( &$$ , $1,  0 );  curVar.type = $1 ;   }  
	| INT		{ stringncatAndAssignment ( &$$ , $1,  0 );  curVar.type = $1 ;   }  
	| LONG		{ stringncatAndAssignment ( &$$ , $1,  0 );  curVar.type = $1 ;   }  
	| FLOAT		{ stringncatAndAssignment ( &$$ , $1,  0 );  curVar.type = $1 ;   }  
	| DOUBLE		{ stringncatAndAssignment ( &$$ , $1,  0 );  curVar.type = $1 ;   }  
	| SIGNED		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| UNSIGNED		{ stringncatAndAssignment ( &$$ , $1,  0 );   curVar.isUnsigned = 1 ;}  
	| struct_or_union_specifier		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| enum_specifier		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| TYPE_NAME		{ stringncatAndAssignment ( &$$ , $1,  0 );     curVar.type = $1 ;  curVar.isStruct = 1 ; }  
	;

struct_or_union_specifier
	: struct_or_union IDENTIFIER '{' struct_declaration_list '}'		{ stringncatAndAssignment ( &$$ , $1, $2, "{", $4, "}",  0 );  
																			struct_with_name( $2 , $4 );   }  
	| struct_or_union '{' struct_declaration_list '}'		{ stringncatAndAssignment ( &$$ , $1, "{", $3, "}",  0 );   }  
	| struct_or_union IDENTIFIER		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );     curVar.isStruct = 1 ; curVar.type = $2 ;}  
	;

struct_or_union
	: STRUCT		{ stringncatAndAssignment ( &$$ , $1,  0 );  }  
	| UNION		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	;

struct_declaration_list
	: struct_declaration		{ stringncatAndAssignment ( &$$ , $1,  0 );    clearCurVar(); }  
	| struct_declaration_list struct_declaration		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );    clearCurVar(); }  
	;

struct_declaration
	: specifier_qualifier_list struct_declarator_list ';'		{ stringncatAndAssignment ( &$$ , $1, $2, ";",  0 );   }  
	;

specifier_qualifier_list
	: type_specifier specifier_qualifier_list		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	| type_specifier		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| type_qualifier specifier_qualifier_list		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	| type_qualifier		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	;

struct_declarator_list
	: struct_declarator		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| struct_declarator_list ',' struct_declarator		{ stringncatAndAssignment ( &$$ , $1, ",", $3,  0 );   }  
	;

struct_declarator
	: declarator		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| ':' constant_expression		{ stringncatAndAssignment ( &$$ , ":", $2,  0 );   }  
	| declarator ':' constant_expression		{ stringncatAndAssignment ( &$$ , $1, ":", $3,  0 );   }  
	;

enum_specifier
	: ENUM '{' enumerator_list '}'		{ stringncatAndAssignment ( &$$ , $1, "{", $3, "}",  0 );   }  
	| ENUM IDENTIFIER '{' enumerator_list '}'		{ stringncatAndAssignment ( &$$ , $1, $2, "{", $4, "}",  0 );  
													  curVar.type = $2 ; }  
	| ENUM IDENTIFIER		{ stringncatAndAssignment ( &$$ , $1, $2,  0 ); 
							  curVar.type = $2 ;  }  
	;

enumerator_list
	: enumerator		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| enumerator_list ',' enumerator		{ stringncatAndAssignment ( &$$ , $1, ",", $3,  0 );   }  
	;

enumerator
	: IDENTIFIER		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| IDENTIFIER '=' constant_expression		{ stringncatAndAssignment ( &$$ , $1, "=", $3,  0 );   }  
	;

type_qualifier
	: CONST		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| VOLATILE		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	;

declarator
	: pointer direct_declarator		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );  }  
	| direct_declarator		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	;

direct_declarator
	: IDENTIFIER		{ stringncatAndAssignment ( &$$ , $1,  0 );   curVar.name = $1 ; }  
	| '(' declarator ')'		{ stringncatAndAssignment ( &$$ , "(", $2, ")",  0 );   }  
	| direct_declarator '[' constant_expression ']'		{ stringncatAndAssignment ( &$$ , $1, "[", $3, "]",  0 );  addArrayDem($3);}  
	| direct_declarator '[' ']'		{ stringncatAndAssignment ( &$$ , $1, "[", "]",  0 );   addArrayDem(""); }  
	| direct_declarator '(' parameter_type_list ')'		{ stringncatAndAssignment ( &$$ , $1, "(", $3, ")",  0 );   }  
	| direct_declarator '(' identifier_list ')'		{ stringncatAndAssignment ( &$$ , $1, "(", $3, ")",  0 );   curVar.name = $3 ;  }  
	| direct_declarator '(' ')'		{ stringncatAndAssignment ( &$$ , $1, "(", ")",  0 );   }  
	;

pointer
	: '*'		{ stringncatAndAssignment ( &$$ , "*",  0 );   curVar.nPointer ++ ; }  
	| '*' type_qualifier_list		{ stringncatAndAssignment ( &$$ , "*", $2,  0 );  curVar.nPointer ++ ; }  
	| '*' pointer		{ stringncatAndAssignment ( &$$ , "*", $2,  0 );   curVar.nPointer ++ ;}  
	| '*' type_qualifier_list pointer		{ stringncatAndAssignment ( &$$ , "*", $2, $3,  0 );   curVar.nPointer ++ ;}  
	;

type_qualifier_list
	: type_qualifier		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| type_qualifier_list type_qualifier		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	;


parameter_type_list
	: parameter_list		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| parameter_list ',' ELLIPSIS		{ stringncatAndAssignment ( &$$ , $1, ",", $3,  0 );   }  
	;

parameter_list
	: parameter_declaration		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| parameter_list ',' parameter_declaration		{ stringncatAndAssignment ( &$$ , $1, ",", $3,  0 );   }  
	;

parameter_declaration
	: declaration_specifiers declarator		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	| declaration_specifiers abstract_declarator		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	| declaration_specifiers		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	;

identifier_list
	: IDENTIFIER		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| identifier_list ',' IDENTIFIER		{ stringncatAndAssignment ( &$$ , $1, ",", $3,  0 );   }  
	;

type_name
	: specifier_qualifier_list		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| specifier_qualifier_list abstract_declarator		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	;

abstract_declarator
	: pointer		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| direct_abstract_declarator		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| pointer direct_abstract_declarator		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	;

direct_abstract_declarator
	: '(' abstract_declarator ')'		{ stringncatAndAssignment ( &$$ , "(", $2, ")",  0 );   }  
	| '[' ']'		{ stringncatAndAssignment ( &$$ , "[", "]",  0 );   yyerror( "TODO" );}  
	| '[' constant_expression ']'		{ stringncatAndAssignment ( &$$ , "[", $2, "]",  0 );   yyerror( "TODO" ); }  
	| direct_abstract_declarator '[' ']'		{ stringncatAndAssignment ( &$$ , $1, "[", "]",  0 );   yyerror( "TODO" ); }  
	| direct_abstract_declarator '[' constant_expression ']'		{ stringncatAndAssignment ( &$$ , $1, "[", $3, "]",  0 );   yyerror( "TODO" );}  
	| '(' ')'		{ stringncatAndAssignment ( &$$ , "(", ")",  0 );   }  
	| '(' parameter_type_list ')'		{ stringncatAndAssignment ( &$$ , "(", $2, ")",  0 );   }  
	| direct_abstract_declarator '(' ')'		{ stringncatAndAssignment ( &$$ , $1, "(", ")",  0 );   }  
	| direct_abstract_declarator '(' parameter_type_list ')'		{ stringncatAndAssignment ( &$$ , $1, "(", $3, ")",  0 );   }  
	;

initializer
	: assignment_expression		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| '{' initializer_list '}'		{ stringncatAndAssignment ( &$$ , "{", $2, "}",  0 );   }  
	| '{' initializer_list ',' '}'		{ stringncatAndAssignment ( &$$ , "{", $2, ",", "}",  0 );   }  
	;

initializer_list
	: initializer		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| initializer_list ',' initializer		{ stringncatAndAssignment ( &$$ , $1, ",", $3,  0 );   }  
	;

statement
	: labeled_statement		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| compound_statement		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| expression_statement		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| selection_statement		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| iteration_statement		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| jump_statement		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	;

labeled_statement
	: IDENTIFIER ':' statement		{ stringncatAndAssignment ( &$$ , $1, ":", $3,  0 );   }  
	| CASE constant_expression ':' statement		{ stringncatAndAssignment ( &$$ , $1, $2, ":", $4,  0 );   }  
	| DEFAULT ':' statement		{ stringncatAndAssignment ( &$$ , $1, ":", $3,  0 );   }  
	;

compound_statement
	: '{' '}'		{ stringncatAndAssignment ( &$$ , "{", "}",  0 );   }  
	| '{' statement_list '}'		{ stringncatAndAssignment ( &$$ , "{", $2, "}",  0 );   }  
	| '{' declaration_list '}'		{ stringncatAndAssignment ( &$$ , "{", $2, "}",  0 );   }  
	| '{' declaration_list statement_list '}'		{ stringncatAndAssignment ( &$$ , "{", $2, $3, "}",  0 );   }  
	;

declaration_list
	: declaration		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| declaration_list declaration		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	;

statement_list
	: statement		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| statement_list statement		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	;

expression_statement
	: ';'		{ stringncatAndAssignment ( &$$ , ";",  0 );   }  
	| expression ';'		{ stringncatAndAssignment ( &$$ , $1, ";",  0 );   }  
	;

selection_statement
	: IF '(' expression ')' statement		{ stringncatAndAssignment ( &$$ , $1, "(", $3, ")", $5,  0 );   }  
	| IF '(' expression ')' statement ELSE statement		{ stringncatAndAssignment ( &$$ , $1, "(", $3, ")", $5, $6, $7,  0 );   }  
	| SWITCH '(' expression ')' statement		{ stringncatAndAssignment ( &$$ , $1, "(", $3, ")", $5,  0 );   }  
	;

iteration_statement
	: WHILE '(' expression ')' statement		{ stringncatAndAssignment ( &$$ , $1, "(", $3, ")", $5,  0 );   }  
	| DO statement WHILE '(' expression ')' ';'		{ stringncatAndAssignment ( &$$ , $1, $2, $3, "(", $5, ")", ";",  0 );   }  
	| FOR '(' expression_statement expression_statement ')' statement		{ stringncatAndAssignment ( &$$ , $1, "(", $3, $4, ")", $6,  0 );   }  
	| FOR '(' expression_statement expression_statement expression ')' statement		{ stringncatAndAssignment ( &$$ , $1, "(", $3, $4, $5, ")", $7,  0 );   }  
	;

jump_statement
	: GOTO IDENTIFIER ';'		{ stringncatAndAssignment ( &$$ , $1, $2, ";",  0 );   }  
	| CONTINUE ';'		{ stringncatAndAssignment ( &$$ , $1, ";",  0 );   }  
	| BREAK ';'		{ stringncatAndAssignment ( &$$ , $1, ";",  0 );   }  
	| RETURN ';'		{ stringncatAndAssignment ( &$$ , $1, ";",  0 );   }  
	| RETURN expression ';'		{ stringncatAndAssignment ( &$$ , $1, $2, ";",  0 );   }  
	;

translation_unit
	: external_declaration		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| translation_unit external_declaration		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	;

external_declaration
	: function_definition		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	| declaration		{ stringncatAndAssignment ( &$$ , $1,  0 );   }  
	;

function_definition
	: declaration_specifiers declarator declaration_list compound_statement		{ stringncatAndAssignment ( &$$ , $1, $2, $3, $4,  0 );   }  
	| declaration_specifiers declarator compound_statement		{ stringncatAndAssignment ( &$$ , $1, $2, $3,  0 );   }  
	| declarator declaration_list compound_statement		{ stringncatAndAssignment ( &$$ , $1, $2, $3,  0 );   }  
	| declarator compound_statement		{ stringncatAndAssignment ( &$$ , $1, $2,  0 );   }  
	;

%%
#include <stdio.h>

extern char yytext[];
extern int column;
extern FILE* yyin ;


int yyerror(s)
char *s;
{
	fflush(stdout);
	printf("\n%*s\n%*s\n", column, "^", column, s);

	exit(1) ;
	return 1 ;
}

int main( int argc, char *argv[] ) {
	if ( argc > 1 )
		yyin = fopen(argv[1], "r");

	printf("\n\n/* comments , print only \n" );
    yyparse();
    fclose(yyin);

    return 0; 
}
