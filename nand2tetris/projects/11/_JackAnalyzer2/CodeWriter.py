# import inspect
import functools
import json
import os
import re

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
        env["symboltable_subroutine"] = {}
        env["nstatic"] = 0 
        env["nfield"] = 0 

        for child in node.children[3:-1]:
            self.handle( child, env )

        # print "env:" , json.dumps(env , indent=4, sort_keys=True)
        # print "~~"
        # print self.vm_code


        _path , _fname = os.path.split( self._srcFilePath  )  
        _name , _ext = os.path.splitext( _fname  )
        dst_file = os.path.join( _path , _name + ".vm"    )
        with open ( dst_file , "w" ) as fp:
            # vm simulator has some limitation on VM code format
            RE_TIME_LINE_SPACE_LEFT = re.compile( r"\n[ \t]*" )
            self.vm_code = re.sub(RE_TIME_LINE_SPACE_LEFT, "\n" , self.vm_code )
            fp.write(  self.vm_code  )
        return True

    @checkUnhandleValue
    def visit_subroutineDec(self,node,env):
        # init symbol table 
        env["symboltable_subroutine"] = {}
        # init positon 
        env["nLocal"] = 0 
        env["label_if_cnt"] = 0 
        env["label_while_cnt"] = 0 


        env["decl_subroutine_type"] = node.children[0].val
        env["decl_subroutine_ret_type"] = node.children[1].val
        env["decl_subroutine_name"] = node.children[2].val
        
        self.writeCode( """
        function {}.{} <placeholder_nLocal>
        """.format( env["class_name"], env["decl_subroutine_name"]  ) )

        bImplyThis = False 
        if "constructor" == env["decl_subroutine_type"]:
            self.writeCode( """
            push constant <placeholder_nSize>
            call Memory.alloc 1
            // anchors this at the base address
            pop pointer 0  
            """)
        elif "method" == env["decl_subroutine_type"]:
            bImplyThis = True
            self.writeCode( """
            push argument 0
            // anchors this at the base address
            pop pointer 0  
            """)
        
        if bImplyThis :
            self.add2symboltable( env, 1, "this" , env["class_name"] , "argument" )


        for child in node.children[4:]:
            self.handle( child, env )
        
        # after everything is done, calc number of needed space of  local variable 
        self.vm_code = self.vm_code.replace( "<placeholder_nLocal>" , str(env["nLocal"])  )
        self.vm_code = self.vm_code.replace( "<placeholder_nSize>" , str(env["nfield"])  )
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
            var_type,var_kind, var_pos  = self.findFromSymbolTable( env,  env["call_classvar"] )
            if var_type is None:
                classVar = env["call_classvar"]
            else :
                self.writeCode( """
                push {} {}
                """.format( var_kind,  var_pos ) )
                classVar = var_type
                nParam += 1

            env["call_subroutinename"] = node.children[2].val
            self.writeCode( """
            call {}.{} {}
            """.format( classVar ,  env["call_subroutinename"], nParam ) )
        else:
            # call self method
            for child in node.children[3-2:]:
                self.handle( child, env )

            env["call_classvar"] = None
            env["call_subroutinename"] = node.children[2-2].val
            self.writeCode( """
            push pointer 0
            call {}.{} {}
            """.format( env["class_name"], env["call_subroutinename"], nParam+1 ) )

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
                # when you access a field , you actually access this[i]
                return prop["type"] , prop["kind"] == "field" and "this" or prop["kind"] , prop["position"]

        return None ,None, None 
        
        
        

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

    @checkUnhandleValue
    def visit_classVarDec(self,node,env):
        kind = node.children[0].val
        t = node.children[1].val
        for i in xrange( 2 , len(node.children), 2  ):
            var_name =  node.children[i].val
            env["n" + kind ] += 1
            self.add2symboltable( env, 0, var_name , t , kind ) 

        return True 

    
    @checkUnhandleValue
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
        # 'return ;'  , len=2, should push a value to stack

        pushContent = ""
        if len(node.children) < 3 :
            pushContent = "push constant 0"
        self.writeCode( """
        {}
        return 
        """.format( pushContent ) )
        return True

    @checkUnhandleValue
    def visit_letStatement(self,node,env):
        var_name = node.children[1].val 
        var_type,var_kind, var_pos  = self.findFromSymbolTable( env, var_name )

        # handle left array access at first 
        bArrayStore =  len( node.children[2].children ) > 0 
        if bArrayStore:
            self.writeCode( """
            // push array address for further computation
            push {} {}
            """.format( var_kind, var_pos ) )

            self.visit_ARRAY_SUB(  node.children[2] , env, True  )


        # then handle right expression 
        for child in node.children[4:]:
            self.handle( child , env )
        # assignment 
        assert var_type is not None  , "can not find var property of '{}' from symbol table".format( var_name )

        if bArrayStore:
            self.writeCode( """
            // right value -> temp 0
            pop temp 0 

            // now that is pointer arr[x]
            pop pointer 1
            // push right value to stack
            push temp 0
            """ )
        
        if bArrayStore:
            self.writeCode("""
            // store to a[], stack -> var 
            pop that 0  
            """)
        else:
            self.writeCode("""
            // store , stack -> var 
            pop {} {}  
            """.format( var_kind, var_pos  )  )  

         
        return True

    def visit_whileStatement(self,node,env):
        # for child in node.children:
        #     print child

        label_cnt = env["label_while_cnt"]
        env["label_while_cnt"] += 1 
        # set label for whiel expre
        self.writeCode("""
        label WHILE_EXP{}
        """.format(label_cnt))  

        self.handle( node.children[2], env )
        # not condition , for simple code generation
        self.writeCode("""
        // not here is for easy while code generation
        not 
        """)  
        
        self.writeCode("""
        if-goto WHILE_END{}
        """.format( label_cnt ))  

        self.handle( node.children[5], env )

        self.writeCode("""
        goto WHILE_EXP{0}
        label WHILE_END{0}
        """.format( label_cnt ))  

        return True 

    @checkUnhandleValue
    def visit_ifStatement(self,node,env):
        # for child in node.children:
        #     print child 

        label_cnt = env["label_if_cnt"] 
        env["label_if_cnt"] += 1 

        hasElse = len(node.children) > 9

        self.handle( node.children[2], env )

        # for if , we donot apply neg conditon

        self.writeCode("""
        if-goto IF_TRUE{0}
        goto IF_FALSE{0}
        label IF_TRUE{0}
        """.format( label_cnt ))  

        self.handle( node.children[5], env )

        if hasElse:
            self.writeCode("""
            goto IF_END{}
            """.format( label_cnt ))  


        self.writeCode("""
        label IF_FALSE{}
        """.format( label_cnt))  

        if hasElse:
            self.handle( node.children[9], env )

        if hasElse:
            self.writeCode("""
            label IF_END{}
            """.format( label_cnt ))  

        return True 

    @checkUnhandleValue
    def visit_ARRAY_SUB(self, node, env, isLeftValue = False  ):
        # expr push
        for child in node.children[1:-1]:
            self.handle( child, env )

        self.writeCode( """
            // arr + offset
            add
            """)

        if not isLeftValue:
            self.writeCode( """
            pop pointer 1 
            // a[] -> stack 
            push that 0  
            """ )


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
    def visit_stringConstant(self,node,env):
        strVal = node.val
        nLen = len(strVal)

        self.writeCode( """
        // string length 
        push constant {}
        call String.new 1
        """.format( nLen ) )

        for ch in strVal :
            self.writeCode( """
            push constant {}
            call String.appendChar 2
            """.format( ord(ch) ) )

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
            # true is -1 
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
        elif node.val == "this":
            self.writeCode( """
            // access this 
            push pointer 0
            """ )
            return True
        elif node.val == "null":
            self.writeCode( """
            push constant 0
            """ )
            return True  




    
