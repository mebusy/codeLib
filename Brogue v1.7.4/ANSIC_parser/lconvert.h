

#include <ctype.h>

typedef struct  {
	char* type ;
	char* name ;
	int nPointer ;
	char* array[8] ;
	char isStruct ;
	char isUnsigned ;
} variableInfo ;

typedef struct variableInfoList {
	variableInfo var ;
	struct variableInfoList * next ;
} variableInfoList ;


extern void struct_with_name( const char* name , const char* struct_declaration_list  ) ;	
extern void stringncatAndAssignment ( char** dst , ...  ) ;
extern char* makeNonterminalString(   ) ;
extern void addArrayDem( char*  dem );
extern void clearCurVar() ;

extern variableInfo curVar ;
extern struct variableInfoList* head  ;
extern int printArrayDeclaration( char* pt_buf , int nPointer ) ;
extern int printObjectArrayDeclaration( char* pt_buf , struct variableInfoList* pt ) ;
extern int printArrayInitialze( char* pt_buf , char*  type_buf , struct variableInfoList* pt ) ;

extern char isStructType( char* str );

