//
//  touchKeyboard.c
//  Brogue
//
//  Created by qibinyi on 12/12/16.
//
//
#include <string.h>
#include <stdio.h>


typedef void (*FuncPtrVoid)(  );
FuncPtrVoid _OpenKeyboardFunc = NULL ;

void SetOpenKeyboardFunction(FuncPtrVoid fp )
{
    _OpenKeyboardFunc = fp;
}

void openKeyboard() {
    if(_OpenKeyboardFunc!=NULL)
        _OpenKeyboardFunc();
}
