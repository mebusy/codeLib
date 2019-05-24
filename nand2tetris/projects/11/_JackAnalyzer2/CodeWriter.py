# import inspect
import functools

class CodeWriter():
    def __init__(self):
        self.symbol_table_class = {}
        self.symbol_table_subroutine = {}

    def initClassSymbolTable(self):
        self.symbol_table_class = {}

    def initSubroutineSymbolTable(self, isFunciont = False):
        self.symbol_table_subroutine = {}

    def __getattr__(self, name):
        if name.startswith( "visit" )  :
            def method(*args):
                if args and len(args) == 1 :
                    print("tried to handle unknown method " + name, str(args)  )
                else:
                    raise Exception( "access unexist attr "  + name )
            
            return method
        else:
            raise Exception( "access unexist attr "  + name )


    def checkUnhandleValue(f):
        @functools.wraps(f)
        def wrapper(*args, **kwargs):
            ret = f(*args, **kwargs)
            if ret is None:
                print 'unhandle value "{}" in function: {}'.format( args[1]  , f.__name__ )
        return wrapper

    @checkUnhandleValue
    def visit_class(self, val):
        if val == 'NTstart':
            self.initClassSymbolTable()
            return 
        
        


        

