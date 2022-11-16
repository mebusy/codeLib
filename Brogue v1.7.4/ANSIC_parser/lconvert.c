#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include <stdlib.h>
#include "lconvert.h"
#include <search.h>

extern int yyerror(char *s) ;

const char* NAMESPACE = "rogueSharp" ;

const char* fmt_struct2class =  "\n*/\n\n"
								"namespace %s \n"
								"{ \n"
								"    public class %s { \n"
								"%s \n"
								"        public %s() { \n"
								"%s \n"
								"        } // constructure  \n"
								"    } // class \n"
								"} // namespace \n\n\n // " ;


char stringIsNumber( char* str  ) {
	for(int i = 0; str[i] != '\0'; ++i) {
        if(! (isdigit(str[i]) || '.' == str[i]) ) {
            //printf("The string has characters that are not numbers or period!");
            return 0;
        }
    }

    return 1 ;
}

void struct_with_name( const char* name , const char* struct_declaration_list  ) {

	ENTRY e, *ep;
	hcreate ( 32 ) ;

	//*
	char buf[4096] ;
	memset( buf , 0 , sizeof(buf) ) ;

	char constructor_buf[4096] ;
	memset( constructor_buf , 0 , sizeof(constructor_buf) ) ;	

	struct variableInfoList* pt ;
	
	int result = 0 ;
	char* pt_buf = buf ;
	char* pt_constructor_buf = constructor_buf ;
	
	char type_buf[64] ;
	pt = head ;
	while( pt != NULL ) {

		for ( int i=0 ; i< sizeof( pt->var.array ) / sizeof( pt->var.array [0]) ; i++  ) {
			if (  pt->var.array [i] == NULL ) {
				break ;
			}

			e.key = pt->var.array [i] ;
        	ep = hsearch(e, FIND);

        	if(ep != NULL)
        		continue ;

			if( ! stringIsNumber(pt->var.array [i]) ) {
				pt_buf += sprintf( pt_buf , "        const int %s = RogueH.%s; \n" , pt->var.array [i] ,pt->var.array [i]   );

				e.key = pt->var.array [i] ;
		        e.data = pt->var.array [i] ;
		        ep = hsearch(e, ENTER);
			}
		}
		pt = pt->next;
	}
	pt_buf += sprintf( pt_buf , "\n" );

	pt = head ;
	while( pt != NULL ) {
		// type
		memset( type_buf , 0 , sizeof(type_buf) ) ;
		char* ir_tyep =  pt->var.type ;
		if (strcmp(pt->var.type , "boolean" )==0)
			ir_tyep = "bool" ;
		else if ( pt->var.isUnsigned  && strcmp(pt->var.type , "char" )==0) {
			pt->var.isUnsigned = 0 ;
			ir_tyep = "byte" ;
		}		
		else if (strcmp(pt->var.type , "uchar" )==0) {
			pt->var.isUnsigned = 1 ;
			ir_tyep = "short" ;
		}

		sprintf( type_buf , "%s%s" , pt->var.isUnsigned ? "u" : "" ,ir_tyep ) ;


		char bIsArray = pt->var.array[0] != 0 ;
		char nPointer = pt->var.nPointer   ;
		char bIsStruct =pt->var.isStruct ;

		char bSetToReadonly = (bIsStruct && pt->var.nPointer ==0 ) || (!bIsStruct && !nPointer &&  bIsArray )  ;

		pt_buf += sprintf( pt_buf , "        public %s %s " , bSetToReadonly?"readonly" : "" ,  type_buf  );


		if ( bIsStruct ) {
			// object type
			if ( pt->var.nPointer > 1 ) {
				yyerror( "multi object pointer is not supported !!" );
			}

			// pointer will not initiialize , other's are same
			if ( bIsArray ) {
				pt_buf += printObjectArrayDeclaration( pt_buf , pt ) ;
				pt_buf += sprintf( pt_buf , " %s " , pt->var.name );	
				
			} else {
				// 
				pt_buf += sprintf( pt_buf , "%s " , pt->var.name );	
			}

			if (  pt->var.nPointer ==0  ) {
				pt_buf += printArrayInitialze(   pt_buf ,   type_buf ,  pt ) ;

				if ( !bIsArray ) {
					pt_buf += sprintf( pt_buf , "() "  );	
				} else {

					// initialize in constructure
					int dem = 0 ;

					// open
					for ( int i=0 ; i< sizeof( pt->var.array ) / sizeof( pt->var.array [0]) ; i++  ) {
						if (  pt->var.array [i] == NULL ) {
							break ;
						}
						
						char var_for_loop = 'i' + i ;
						pt_constructor_buf += sprintf ( pt_constructor_buf ,  "%*sfor (int %c = 0; %c < %s; %c++) { \n" , 4*(3+i), " " ,
							  var_for_loop , var_for_loop , pt->var.array [i] ,  var_for_loop ) ;

						dem ++ ;
					}

					// initialize 
					pt_constructor_buf += sprintf ( pt_constructor_buf ,  "%*s%s [i" ,4*(3+dem), " " , pt->var.name ) ; 
					for ( int i= 1 ; i < dem   ; i++  ) {
						if (  pt->var.array [i] == NULL ) {
							break ;
						}
						pt_constructor_buf += sprintf ( pt_constructor_buf ,  ",%c"  , 'i' + i ) ; 
					}
					pt_constructor_buf += sprintf ( pt_constructor_buf ,  "]= new %s() ; \n"  , type_buf ) ; 

					// close
					for ( int i= dem -1 ; i>=0  ; i--  ) {
						if (  pt->var.array [i] == NULL ) {
							break ;
						}
						pt_constructor_buf += sprintf ( pt_constructor_buf ,  "%*s} \n" ,4*(3+i), " " ) ; 
					}
				}
			}
 

		} else {
			// basic type

			if ( bIsArray &&  nPointer ) {
				yyerror( "array pointer is not supported !!" );
			}

			/*
			if ( strcmp(pt->var.name , "scentMap" ) ==0  ) {
				printf ( " ~~~~~~~~~~~~~ %d" , nPointer ) ;
			}
			//*/

			if ( nPointer ) {
				pt_buf += printArrayDeclaration( pt_buf , nPointer ) ;
				pt_buf += sprintf( pt_buf , " %s " , pt->var.name );	
			} 
			else if ( bIsArray ) {
				pt_buf += printArrayDeclaration( pt_buf , nPointer ) ;
				pt_buf += sprintf( pt_buf , " %s " , pt->var.name );	
				pt_buf += printArrayInitialze(   pt_buf ,   type_buf ,  pt ) ;
			} else {
				// 
				pt_buf += sprintf( pt_buf , "%s " , pt->var.name );	
			}
		}

		// end line
		pt_buf += sprintf( pt_buf , "%s" , ";\n" );		
		
		pt = pt->next;
	}
	//*/

	printf( fmt_struct2class , NAMESPACE , name  , buf , name , constructor_buf );

	hdestroy();
}

int printArrayDeclaration( char* pt_buf , int nPointer ) {
	char* pStart = pt_buf ;
	pt_buf += sprintf( pt_buf , "[" );	
	for(int i=1 ; i< nPointer ; i++) {
		pt_buf += sprintf( pt_buf , "," );	
	}
	pt_buf += sprintf( pt_buf , "]" );	

	return pt_buf - pStart  ;
}

int printObjectArrayDeclaration( char* pt_buf , struct variableInfoList* pt ) {
	char* pStart = pt_buf ;
	pt_buf += sprintf( pt_buf , "[" );	
	for ( int i=1 ; i< sizeof( pt->var.array ) / sizeof( pt->var.array [0]) ; i++  ) {
		if (  pt->var.array [i] == NULL ) {
			break ;
		}
		pt_buf += sprintf( pt_buf , ","   );
	}
	pt_buf += sprintf( pt_buf , "]" );	

	return pt_buf - pStart  ;
}

int printArrayInitialze( char* pt_buf , char*  type_buf , struct variableInfoList* pt ) {
	char* pStart = pt_buf ;

	char bArrayInitialize = 0 ;
	pt_buf += sprintf( pt_buf , " = new %s " , type_buf );
	for ( int i=0 ; i< sizeof( pt->var.array ) / sizeof( pt->var.array [0]) ; i++  ) {
		if (  pt->var.array [i] == NULL ) {
			break ;
		}
		if ( i==0) {
			pt_buf += sprintf( pt_buf , "["   );
		} else {
			pt_buf += sprintf( pt_buf , ","  );
		}
		pt_buf += sprintf( pt_buf , "%s" , pt->var.array [i]  );

		bArrayInitialize = 1 ;
	}

	if(bArrayInitialize) {
		pt_buf += sprintf( pt_buf , "]"  );
	}
	

	return pt_buf - pStart  ;
}

char* makeNonterminalString(  ) {
	char* buf ;
	if ((buf = (char*)malloc( 32)) == NULL)
        yyerror("out of memory");

	int result = sprintf( buf , "%s" ,  "makeNonterminalString;\n" );
	buf[result] = '\0' ;

	return buf ;
}

void stringncatAndAssignment ( char** dst , ...  ) {

	
	va_list ap; 
	int len = 0 ;
	char* temp ;

	va_start(ap, dst );

	while ((temp = va_arg(ap, char*)) != 0)
    {
        len += strlen( temp ) ;  
        len +=1 ; // add 1 space
    }
    va_end(ap);

    //printf( "len: %d" , len   );

    char* buf =  malloc(len);
    char* pt = buf ;
	va_start(ap, dst );
	int cnt = 0 ;
	while ((temp = va_arg(ap, char*)) != 0)
    {
    	if (cnt > 0) {
       		// add space
       		sprintf( pt , "%s" , " "  );  // 1 space plus
       		pt ++ ;
       	}

        int result = sprintf( pt , "%s" , temp  );  
        
        pt += result ;

        if( result == -1) 
        	yyerror( "stringncatAndAssignment sprintf error !" );


       	cnt ++ ;
    }
    // add final '\0'
    *(pt) = '\0' ;
		
    
    va_end(ap);

    *dst = buf ;
	//*/
}

variableInfo curVar ;

struct variableInfoList* head = NULL ;

void clearCurVar() {
	/*
	printf( "\n\t\t\t\t\t\t type:%s %s, name: %s,  %s%d ,   %s, " , 

	
	curVar.isUnsigned? "unsign":"" ,  curVar.type, 
	curVar.name ,

	curVar.nPointer >0 ? "pointer:" : "" ,
	curVar.nPointer  ,
	curVar.isStruct? "isStruct":"" );

	printf( "array: " ) ;
	for ( int i=0 ; i< sizeof(curVar.array ) / sizeof(curVar.array [0]) ; i++  ) {
		if ( curVar.array [i] == NULL ) {
			break ;
		}
		printf( "%s " , curVar.array [i]  ) ;
	}
	printf( "\n" ) ;
	//*/

	if (curVar.name != NULL) {

		struct variableInfoList *p ;
		// allocate node 
	    if ((p = malloc(sizeof(variableInfoList))) == NULL)
	        yyerror("out of memory");

	    p->var = curVar ;
	    p->next = NULL ;


	    if (head == NULL)
	    	head = p ;
	    else {
	    	//printf( "\n 				to add  :  %s \n" , p->var.name ) ;

	    	struct variableInfoList* pt = head  ;
	    	while( pt->next != NULL  ) {
	    		pt = pt->next ;
			}
	    	pt->next = p ;

	    }
    }


    // clean context

	curVar.type = NULL ;
	curVar.name = NULL ;
	curVar.nPointer = 0 ;
	
	curVar.isStruct = 0 ;
	curVar.isUnsigned = 0 ;

	memset( curVar.array , 0 , sizeof( curVar.array  ) ) ;
}

void addArrayDem( char*  dem ) {
	for ( int i=0 ; i< sizeof(curVar.array ) / sizeof(curVar.array [0]) ; i++  ) {
		if ( curVar.array [i] == 0 ) {
			curVar.array [i] = dem ;
			return ;
		}
	}

	yyerror( "addArrayDem error " ) ;
}

char* typeList[]= { 
						 //"pcell" , 
						 "cellDisplayBuffer" , 
						 "randomRange" , 
						 "color" , 
						 "keyLocationProfile" ,
						 "creatureType" , 
						 "item" ,
						 //"flare" ,
						 "creature" ,
						 //"lightSource" ,
						 } ;

char isStructType( char* str ) {
	for ( int i=0 ; i< sizeof( typeList ) / sizeof(typeList[0]) ; i++ ) {
		if ( strcmp( typeList[i] , str)==0 )
			return 1 ;
	}
	return 0 ;
}



