

#include "coroutine.h"

void main(void) {
    ccrContext z = 0;
    do {
       printf("got number %d\n", ascending (&z));
    } while (z);
}


int ascending (ccrContParam) {
    printf("1\n") ;
    ccrBeginContext;
    int i;
    ccrEndContext(foo);

    printf("2\n") ;
    ccrBegin(foo);
	
    printf("3\n") ;

    for (foo->i=0; foo->i<10; foo->i++) {
        printf( " foo count: %d\n" , foo->i  ) ;
		ccrReturn(foo->i);
    }

    printf("4\n") ;
    ccrFinish(-1);
}
