
import sys
import os
import uuid

def getUniqueLable():
    return "LABEL_" + str(uuid.uuid1()).replace("-","")

def parse(path):
    with open( path ) as fp:
        lines = fp.readlines()

    _path , _fname = os.path.split( path )
    _fn , _ = os.path.splitext( _fname )  

    
    
    writer = CodeWrite( _fn )
    out = []
    for line in lines:
        # print line
        line = line.split( "//" )[0].strip()
        if not line:
            continue 

        out.append( writer.write( line ) )

    # print "\n".join( out ) 

    path_out = os.path.join( _path , _fn+".asm" ) 
    with open( path_out , "w") as fp:
        fp.write( "\n".join( out )   ) 

class CodeWrite( object ) :
    def __init__(self, filename ) :
        self.filename = filename 
        # 5 pointer
        # self.SP = 0
        # self.LCL = 1
        # self.ARG = 2
        # self.THIS = 3
        # self.THAT = 4
        
        # base addres
        self.temp = 5   # 5-12 , 8 register
        self.static = 16 # 16-256  global variable

        # constant
        # pointer


        # SP,  R0 ... R15 
        self.asm_predfined = {
            "local" : "LCL" ,    
            "argument" : "ARG" ,    
            "this" : "THIS" ,    
            "that" : "THAT" ,    
        }
        
        self.asm_arithmetic_mapping = {
            "add" : "+" ,   
            "sub" : "-" ,
            "neg" : "-" , 
            "and" : "&" , 
            "or"  : "|" , 
            "not" : "!" ,

            "gt" : "JGT" ,
            "lt" : "JLT" , 
            "eq" : "JEQ" , 
        }

    def asm_LoadSuppliedContent2D( self, index) :
        code = """
        // D = supplied data 
        @{0}
        D=A
        """.format( index )
        return code

    def asm_LoadMemoryContent2D( self, address ) :
        code = """
        @{0}
        D=M 
        """.format( address  )

        return code 

    def asm_LoadStaticContent2D( self , index  ):
        code = """
        @{0}.{1}
        D=M
        """.format( self.filename , index )
        
        return code

    def asm_LoadSegContent2D( self, seg, index ) :
        code = """
        // D = *{0} get seg start localtion
        @{0}
        D=M
        // add offset by index 
        @{1}
        A=D+A
        D=M
        """.format( self.asm_predfined[seg], index )
        return code


    def asm_PushDreg2Stack(self):    
        code = """
        // *SP = D
        @SP
        A=M
        M=D
        // SP++
        @SP
        M=M+1
        """

        return code

    def asm_StorePoped2Memory( self, address ) :
        code = """
        @SP
        A=M
        D=M
        @{0}
        M=D
        """.format( address )

        return code 

    def asm_StorePoped2Static( self , index  ):
        code = """
        @SP
        A=M
        D=M
        @{0}.{1}
        M=D
        """.format( self.filename , index )
        
        return code

    def asm_StorePoped2Seg( self, seg, index ) :
        code = """
        // D = *{0} get seg start localtion
        @{0}
        D=M
        // add offset by index 
        @{1}
        D=D+A
        
        // seg address -> Mem(*SP+1)
        @SP
        A=M+1
        M=D

        // pop 2 D
        @SP
        A=M
        D=M
        // SP+1
        A=A+1 
        // seg 
        A=M 
        M=D  
        """.format( self.asm_predfined[seg], index )

        return code

    def asm_Pop( self  ) :
        code = """
        // SP--
        @SP
        M=M-1
        """

        return code 

    def asm_2operand_arithmetic(self, oper) :
        
        code = """
        // SP--
        @SP
        M=M-1

        // pointer to 1st operand
        A=M-1  
        D=M

        // comp , and store result to D
        A=A+1
        D=D{0}M

        A=A-1
        M=D
        """.format( self.asm_arithmetic_mapping[ oper]  )

        return code 

    def asm_1operand_arithmetic(self, oper) :
        
        code = """
        @SP
        A=M-1
        M={0}M
        """.format(  self.asm_arithmetic_mapping[ oper]   ) 
    
        return code 

    def asm_2operand_logic(self, oper) :
        

        code = """
        // SP--
        @SP
        M=M-1

        // pointer to 1st operand
        A=M-1  
        D=M

        // comp , and store result to D
        A=A+1
        D = D-M

        A=A-1
        M=-1
        
        @{1}
        D ; {0} 

        // false
        @SP
        A=M-1
        M=0
    ({1})
        """.format( self.asm_arithmetic_mapping[ oper] , getUniqueLable()  )

        return code 

    def asm_1operand_logic(self ,oper) :
        code = """
        @SP
        A=M-1
        D=M 

        M=-1 

        @{1}
        D ; {0} 

        // false
        @SP
        A=M-1
        M=0
    ({1})
        """.format( self.asm_arithmetic_mapping[ oper] , getUniqueLable()  )

        return code 

    def write(self, vmcode):
        # print vmcode
        cmds = vmcode.split()
        assert len(cmds) >= 1

        asm_codes = ["// "+vmcode] 
        operator = cmds[0]
        if operator in ["push" , "pop"] :
            assert len(cmds) == 3

            seg = cmds[1] 
            index  = cmds[2]

            if operator == "push":
                if seg in self.asm_predfined:
                    asm_codes.append( self.asm_LoadSegContent2D( seg, index  ) )
                elif seg in ["constant"] :
                    asm_codes.append( self.asm_LoadSuppliedContent2D( index ) )
                elif seg in ["pointer"] :
                    asm_codes.append( self.asm_LoadMemoryContent2D( (int)(index) == 0 and "THIS" or "THAT") )
                elif seg in ["temp"] :
                    asm_codes.append( self.asm_LoadMemoryContent2D(  self.temp  + int(index) ) )
                elif seg in ["static"] :
                    asm_codes.append( self.asm_LoadStaticContent2D( index ) )
                else:
                    raise Exception( "wrong segment name:" + seg )
                asm_codes.append(  self.asm_PushDreg2Stack() )
            elif operator == "pop":      
                asm_codes.append( self.asm_Pop() ) 
                if seg in self.asm_predfined:
                    asm_codes.append( self.asm_StorePoped2Seg ( seg, index  ) )
                    
                elif seg in ["pointer"] :
                    asm_codes.append( self.asm_StorePoped2Memory(  (int)(index) == 0 and "THIS" or "THAT"   ) )
                elif seg in ["temp"] :
                    asm_codes.append( self.asm_StorePoped2Memory (  self.temp  + int(index) ) )
                elif seg in ["static"] :
                    asm_codes.append( self.asm_StorePoped2Static(  index ) )
                else:
                    raise Exception( "wrong segment name:" + seg )
            else:
                raise Exception( "wrong operator name:" + operator )

        else:
            assert len(cmds) == 1

            if operator in ["add","sub","and","or"]:
                asm_codes.append( self.asm_2operand_arithmetic( operator ))
            elif operator in ["neg","not"]:
                asm_codes.append( self.asm_1operand_arithmetic( operator ))
            elif operator in ["gt","lt", "eq"] : 
                asm_codes.append( self.asm_2operand_logic( operator ))
            else :
                raise Exception( "wrong operator name:" + operator )  



        return "\n".join(asm_codes)

    
 

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print 'usaeg: python2.7 VMTranslator.py  path_vm ' 
        sys.exit(0)
    
    path = sys.argv[1] 
    parse( path )
    

    print 'done'
