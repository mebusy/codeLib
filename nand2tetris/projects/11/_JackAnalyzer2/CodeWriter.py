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
        return "'{}' '{}' {}-child".format( self.type,self.val, len(self.children) )


class CodeWriter():
    def __init__(self):
        self.symbol_table_name = [
            "symboltable_class"  ,
            "symboltable_subroutine"  ,
        ] 
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
        env["symboltable_class"] = {}

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
        # init symbol table 
        env["symboltable_subroutine"] = {}
        # init positon 
        env["nLocal"] = 0 

        env["decl_subroutine_type"] = node.children[0].val
        env["decl_subroutine_ret_type"] = node.children[1].val
        env["decl_subroutine_name"] = node.children[2].val
        
        self.writeCode( """
        function {}.{} <placeholder_nLocal>
        """.format( env["class_name"], env["decl_subroutine_name"]  ) )

        for child in node.children[4:]:
            self.handle( child, env )
        
        # after everything is done, calc number of needed space of  local variable 
        self.vm_code = self.vm_code.replace( "<placeholder_nLocal>" , str(env["nLocal"])  )
        # print env["symboltable_subroutine"] 
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
        return node.children[1].val == "."
        
    def getParamNumber(self, node):
        for child in node.children:
            if child.type == "expressionList" :
                return (len( child.children ) + 1 ) / 2 

        return 0
    
    @checkUnhandleValue
    def visit_subroutineCall(self,node,env):
        clsFuncCall = self.isClassFuncCall( node )
        nParam = self.getParamNumber(node)
        if clsFuncCall :
            for child in node.children[3:]:
                self.handle( child, env )

            env["call_classvar"] = node.children[0].val 
            env["call_subroutinename"] = node.children[2].val
            self.writeCode( """
            call {}.{} {}
            """.format( env["call_classvar"],  env["call_subroutinename"], nParam ) )
        else:
            for child in node.children[3-2:]:
                self.handle( child, env )

            env["call_classvar"] = None
            env["call_subroutinename"] = node.children[2-2].val
            self.writeCode( """
            call {} {}
            """.format( env["call_subroutinename"], nParam ) )

        return True 

    @checkUnhandleValue
    def visit_doStatement(self,node,env):
        for child in node.children[1:]:
            self.handle(child, env)

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
        # term [op term]*

        # signle term
        self.handle( node.children[0], env )

        if len(node.children) == 1:
            return True 

        # op term 
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
        
    def add2symboltable( self, env, tbl, name, _type, kind ):

        table = env[ self.symbol_table_name[tbl] ]

        nVarWithSameType = 0
        for _,v in table.iteritems():
            if v["kind"] == kind :
                nVarWithSameType += 1

        table[ name ] = { "type":_type, "kind":kind, "position": nVarWithSameType  }    

    def findFromSymbolTable( self, env, name  ):
        for tbl in [1,0]:
            table = env[ self.symbol_table_name[tbl] ]
            if name in table:
                prop =  table[name]
                return prop["type"] , prop["kind"], prop["position"]

        return None 
        
        

    @checkUnhandleValue
    def visit_varDec(self, node,env):
        # for child in node.children:
        #     print child
        t = node.children[1].val
        for i in xrange( 2 , len(node.children), 2  ):
            var_name =  node.children[i].val
            env["nLocal"] += 1
            self.add2symboltable( env, 1, var_name , t , "local" ) 

        return True 
    def visit_parameterList(self,node,env):
        for i in xrange( 0, len(node.children), 3  ):
            t = node.children[i].val
            var_name =  node.children[i+1].val
            self.add2symboltable( env, 1, var_name , t , "argument" )
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
    def visit_letStatement(self,node,env):
        # handl right expression first 
        for child in node.children[3:]:
            self.handle( child , env )
        # assignment 
        var_name = node.children[1].val 
        var_type,var_kind, var_pos  = self.findFromSymbolTable( env, var_name )
        assert var_type is not None 
        
        self.writeCode("""
        pop {} {}
        """.format( var_kind, var_pos  )  )  
         
        return True

    def visit_whileStatement(self,node,env):
        # for child in node.children:
        #     print child

        self.label_while_cnt  = 0 
        # set label for whiel expre
        self.writeCode("""
        label WHILE_EXP{}
        """.format( self.label_while_cnt  ))  

        self.handle( node.children[2], env )
        # not condition , for simple code generation
        self.writeCode("""
        // not here is for easy while code generation
        not 
        """)  
        
        self.writeCode("""
        if-goto WHILE_END{}
        """.format( self.label_while_cnt  ))  

        self.handle( node.children[5], env )

        self.writeCode("""
        goto WHILE_EXP{0}
        label WHILE_END{0}
        """.format( self.label_while_cnt  ))  

        self.label_while_cnt  += 1
        return True 

    @checkUnhandleValue
    def visit_ifStatement(self,node,env):
        for child in node.children:
            print child 
        return True 

    @checkUnhandleValue
    def visit_identifier(self, node, env):
        var_type,var_kind, var_pos  = self.findFromSymbolTable( env, node.val )
        self.writeCode("""
        push {} {}
        """.format( var_kind, var_pos  )  )  
        return True
        

    @checkUnhandleValue
    def visit_integerConstant(self,node,env):
        self.writeCode( """
        push constant {}
        """.format( node.val ) )
        return True

    @checkUnhandleValue
    def visit_symbol(self,node,env):
        if node.val in ["(", ")", ",",";"]:
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
    def visit_keyword(self,node,env):
        if node.val == "true":
            self.writeCode( """
            push constant 0
            not
            """ )
            return True  
        elif node.val == "false":
            self.writeCode( """
            push constant 0
            """ )
            return True  



    
