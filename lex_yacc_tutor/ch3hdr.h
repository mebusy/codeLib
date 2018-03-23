
#define NSYMS	20 /* maximum number of symbols */
struct symtab {
	char *name;
	double (*funcptr) (); 	/* 1 */
	double value; 
} symtab[NSYMS];

struct symtab *symlook( ) ;


