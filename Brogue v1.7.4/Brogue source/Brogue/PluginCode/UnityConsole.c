//
//  UnityConsole.c
//  Brogue
//
//  Created by qibinyi on 11/29/16.
//
//

#include "UnityConsole.h"

FuncPtr _DebugFunc;

void SetDebugFunction(FuncPtr fp )
{
    _DebugFunc = fp;
}

#include <execinfo.h>
#include <stdio.h>
#include <stdlib.h>

/* Obtain a backtrace and print it to stdout. */
void print_trace (void)
{
    void *array[10];
    size_t size;
    char **strings;
    size_t i;
    
    size = backtrace (array, 10);
    strings = backtrace_symbols (array, size);
    
    static char buf[2048] ;
    memset(buf, 0 , sizeof(buf));
    
    char* pt = buf  ;
    int nbytes = sprintf( pt, "Obtained %zd stack frames.\n", size ) ;
    pt += nbytes ;
    
    for (i = 0; i < size; i++) {
        nbytes =  sprintf ( pt, "%s\n", strings[i]);
        pt += nbytes ;
    }
    
    DebugLog("%s\n" , buf) ;
    
    free (strings);
}





