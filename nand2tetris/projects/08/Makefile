
all: test

test_func:
	python VMTranslator.py FunctionCalls/SimpleFunction/
	python VMTranslator.py FunctionCalls/FibonacciElement
	python VMTranslator.py FunctionCalls/StaticsTest
	python VMTranslator.py FunctionCalls/NestedCall/


test:  test_func
	python VMTranslator.py  ProgramFlow/BasicLoop/BasicLoop.vm
	python VMTranslator.py  ProgramFlow/FibonacciSeries/FibonacciSeries.vm

