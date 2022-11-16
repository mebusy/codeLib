package main 

// #cgo pkg-config: python3-embed
// #include <Python.h>
import "C"

/* 
* to check python pkg-config:
*       pkg-config --list-all | grep python  
*/

import (
    "unsafe"
)

func main() {

pycodeGo := `
import sys
for path in sys.path:
    print(path)
`
    
    // Note: 
    // All error handling is left out from the example to keep it simple
    C.Py_Initialize()
    defer C.Py_Finalize()

    pycodeC := C.CString(pycodeGo)
    defer C.free(unsafe.Pointer(pycodeC))

    C.PyRun_SimpleString(pycodeC)

}

