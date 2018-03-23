
%{
#include "stdio.h"
%}

%union {
	char *string ;   /* string buffer */
}

%token COMMAND ACTION IGNORE EXECUTE ITEM TITLE
%token <string> QSTRING ID

%%

screens:  /* empty */
	| screens screen
	;

screen :  screen_name screen_contents screen_terminator
	|	  screen_name screen_terminator
	;

screen_name :   SCREEN ID  			{ start_screen($2) ; }
	|		SCREEN 					{ start_screen( strdup("default") ) ; }
	;

screen_terminator :  END ID 		{ end_screen($2) ; }
	|				END 			{ end_screen( strdup( "default" ) ) ; }
	;

screen_contents:		titles lines
	;


titles:		/* empty */
	| titles title
	;

title:	TITLE 	QSTRING 		{ add_title ($2) ;  }
	;


lines : line
	| lines line
	;

line: ITEM QSTRING command ACTION action attribute  {
														item_str = $2 ;
														add_line( $5 , %6 ) ;
														$$ = ITEM ; 
													}

	;

command:	/* empty */		    { cmd_str = strdup("") ; }
	|		COMMAND ID 			{ cmd_str = $2  ; }
	;

action:		EXECUTE QSTRING 	{ act_str = $2 ;  $$ = EXECUTE; }
	|		MENU ID 			{ act_str = malloc( strlen($2) + 6 ) ;
								  str_cpy(act_str , "menu_" ) ;
								  strcat(act_str , $2) ;
								  free($2) ;
								  $$ = MENU ; 
								}
	|		QUIT 				{ $$ = QUIT ; }
	|		IGNORE				{ $$ = IGNORE ; }
	;

attribute: 	/* empty */  		{ $$ = VISIBLE ;}
	| ATTRIBUTE VISIBLE			{ $$ = VISIBLE ; }
	| ATTRIBUTE INVISIBLE		{ $$ = INVISIBLE ; }
	;


%%

char *progname = "mgl';
int lineno = 1;

#define DEFAULT_OUTFILE "screen.out"

char *usage = "%s: usage [infile] [outfile]\n";

int main( int argc , char** argv) {

	char *outfile;
	char *infile;
	extern FILE *yyin, *yyout;

	progname = argv[0] ;

	if (argc > 3) {
		fprintf( stderr , usage , progname ) ;
		exit(1) ;
	}

	if( argc > 1 ) {
		infile = argv[1] ;
		/* open for read */
		yyin = fopen( infile ,"r" ) ;
		if (yyin == NULL)  /* open failed */
		{
			fprintf( stderr , "%s: cannot open %s \n" ) , progname , infile ) ;
			exit(1) ;
		}
	}

	if(argc > 2 ) {
		outfile = argv[2] ;
	} else {
		outfile = DEFAULT_OUTFILE ;
	}

	yyout = fopen( outfile  , "w" ) ;
	if(yyout == NULL)  {
			fprintf( stderr , "%s: cannot open %s \n" ) , progname , outfile ) ;
			exit(1) ;
	}

	/* normal interactin on yyin and yyout from now on */
    
    yyparse();
	
    end_file() ;  /* write out any finle information */

    /* now check EOF condition */
    if(!screen_donw)   /* in the middle of a screen */
    {
    	warning ( "Premature EOF" , (char*)0) ;
    	unlink( outfile ) ;   /* remove bad file */
    	exit(1) ;
    }

	return 0; 
}

void warning( char *s  , char *t )  /* print warning message */
{
	fprintf(stderr, "%s: %s" , progname , s  ) ;
	if(t) 
		fprintf( stderr, " %s" , t ) ;
	fprintf ( stderr,  " line %d\n" , lineno);
}

/* screen first */
void menu_first() {
	extern struct item menu_first_items[];
	if(!init) menu_init() ;
	clear();
	refresh();
}

void end_screen( char *name  ) {
	
	
}


