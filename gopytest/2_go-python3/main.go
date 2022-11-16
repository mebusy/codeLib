package main

import (
    // "github.com/sbinet/go-python"
    "github.com/DataDog/go-python3"  // only support py3.7
)

func main() {
    python3.Py_Initialize()
    defer python3.Py_Finalize()
    python3.PyRun_SimpleString("print('hello world')")
}

