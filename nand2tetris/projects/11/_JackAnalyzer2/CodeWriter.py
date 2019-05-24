# import inspect
import functools
import json
import os

class Node():
    def __init__(self, _type , val):
        self.type = _type 
        self.val = val
        self.parent = None
        self.children = []

    def add(self, child):
        child.parent = self
        self.children.append( child )

    def __str__(self):
        return "'{}',{} child:{}".format( self.type,self.val, len(self.children) )


class CodeWriter():
    def __init__(self):
        self.vm_code = ""
        pass
    
    def traverse( self, root, level=0 ):
        print " "*2*level , root 

        if len(root.children) == 0:
            return 

        for child in root.children :
            self.traverse( child , level+1 )
         

    def writeCode( self, code ):
        self.vm_code += code

    def __getattr__(self, name):
        if name.startswith( "visit" )  :
            def method(*args):
                if args and len(args) == 2 :
                    print "\ttried to handle unknown method " + name, args[0]
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
                print "\tunhandle '{}' in function: {}".format( args[1].val  , f.__name__ )
        return wrapper
    
    # ===================================

    def handle(self, node, env ):
        method_to_call = getattr(self, 'visit_' + node.type )
        method_to_call( node , env )
    
    @checkUnhandleValue
    def visit_class( self, node, env  ):
        # print val, env
        env["class_name"] = node.children[1].val

        for child in node.children[3:-1]:
            self.handle( child, env )

        print "env:" , json.dumps(env , indent=4, sort_keys=True)
        print "~~"
        print self.vm_code


        _path , _fname = os.path.split( self._srcFilePath  )  
        _name , _ext = os.path.splitext( _fname  )
        dst_file = os.path.join( _path , _name + ".vm"    )
        with open ( dst_file , "w" ) as fp:
            fp.write(  self.vm_code  )
        return True

    @checkUnhandleValue
    def visit_subroutineDec(self,node,env):
        env["symboltable_subroutine"] = {}
        env["decl_subroutine_type"] = node.children[0].val
        env["decl_subroutine_ret_type"] = node.children[1].val
        env["decl_subroutine_name"] = node.children[2].val
        
        self.writeCode( """
        function {}.{} {}
        """.format( env["class_name"], env["decl_subroutine_name"] , 0  ) )

        for child in node.children[4:]:
            self.handle( child, env )
        
        return True



            
    @checkUnhandleValue
    def visit_subroutineBody(self,node,env):
        for child in node.children[1:-1]:
            self.handle( child, env )
        return True

    @checkUnhandleValue
    def visit_statements(self,node,env):
        for child in node.children:
            self.handle( child, env )
        return True

    def isClassFuncCall(self, node):
        return node.children[2].val == "."
        
    def getParamNumber(self, node):
        for child in node.children:
            if child.type == "expressionList" :
                return (len( child.children ) + 1 ) / 2 

        return 0

    @checkUnhandleValue
    def visit_doStatement(self,node,env):
        clsFuncCall = self.isClassFuncCall( node )
        nParam = self.getParamNumber(node)
        if clsFuncCall :
            for child in node.children[4:-2]:
                self.handle( child, env )
            env["call_classvar"] = node.children[1].val 
            env["call_subroutinename"] = node.children[3].val
            self.writeCode( """
            call {}.{} {}
            """.format( env["call_classvar"],  env["call_subroutinename"], nParam ) )
        else:
            for child in node.children[2:-2]:
                self.handle( child, env )
            env["call_classvar"] = None
            env["call_subroutinename"] = node.children[1].val
            self.writeCode( """
            call {} {}
            """.format( env["call_subroutinename"], nParam ) )

        self.writeCode( """
        // the caller of a void method
        // must dump the returned value
        pop temp 0
        """)
        return True

    @checkUnhandleValue
    def visit_expressionList(self,node,env):
        for child in node.children:
            self.handle(child, env)
        return True

    @checkUnhandleValue
    def visit_expression(self,node,env):
        # term
        self.handle( node.children[0], env )
        # term
        self.handle( node.children[2], env )
        
        op = node.children[1].val
        op_vmcode_map = {
            '+' : "add",
            '-' : "sub",
            '*' : "call Math.multiply 2",
            '/' : "call Math.divide 2" ,
            '&' : "and" ,
            '|' : "or" , 
            '<' : "lt" ,
            '>' : "gt" , 
            '=' : "eq" , 
        }

        self.writeCode("""
        {}
        """.format( op_vmcode_map[op]) )
        return True

    @checkUnhandleValue
    def visit_symbol(self,node,env):
        if node.val in ["(", ")"]:
            return True
        if node.val in ["-"]:
            self.writeCode( """
            neg 
            """ )
            return True  
        if node.val in ["~"]:
            self.writeCode( """
            not
            """ )
            return True  

    @checkUnhandleValue
    def visit_term(self,node,env):
        if node.children[0].type == 'symbol' and node.children[0].val in [ "-", "~" ]:
            l = node.children[ 1: ]
            for child in l :
                self.handle( child, env )
            self.visit_symbol( node.children[0], env  )
            return True
            
        l = node.children 
        for child in l :
            self.handle( child, env )

        return True
    
    @checkUnhandleValue
    def visit_returnStatement(self,node,env):
        # handle expr first 
        for child in node.children[1:]:
            self.handle(child,env)

        # handle return finally
        self.writeCode( """
        {}
        return 
        """.format( len(node.children) > 1 and "push constant 0" or "" ) )
        return True

    @checkUnhandleValue
    def visit_integerConstant(self,node,env):
        self.writeCode( """
        push constant {}
        """.format( node.val ) )
        return True

    

    
