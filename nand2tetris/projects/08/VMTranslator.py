
import sys
import os
import uuid
from collections import OrderedDict 

def getUniqueLable():
    return "LABEL_" + str(uuid.uuid1()).replace("-","")

def getUniqueID():
    return str(uuid.uuid1()).replace("-","")

def parseVMFile(path):
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
    return out  ,  writer.asm_Bootstrap()


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

        self.strInFuncName = None 

        # must only 4, it will be used for saving caller's status
        self.predefined_segments = OrderedDict()
        d = self.predefined_segments
     
        # saving / restoring caller's status must follow specific order !!!!
        d["local"] = "LCL"
        d[ "argument" ] = "ARG"     
        d[ "this" ] = "THIS"     
        d[ "that" ] = "THAT" 
        
        
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
        """index: supplied data , it may be 1,2,7,..., or Label , or Memory Address
        it will directly load such data 
        """
        code = """
        // D = supplied data 
        @{0}
        D=A
        """.format( index )
        return code

    def asm_LoadMemoryContent2D( self, address ) :
        """
        address:  memory address ,load content of given memory address 
        """
        code = """
        @{0}
        D=M 
        """.format( address  )

        return code 

    def asm_LoadStaticContent2D( self , index  ):
        """
        index: index is the offset from static pointer,  load  the content of StaticPointer[ index ]
        """

        code = """
        @{0}.{1}
        D=M
        """.format( self.filename , index )
        
        return code

    def asm_LoadSegContent2D( self, seg, index ) :
        """
        seg: segment name , you may use the 4 seg in self.predefined_segments 
        index: offset from specifity segment 
        load the content of Segment[index] to D 
        """

        code = """
        // D = *{0} get seg start localtion
        @{0}
        D=M
        // add offset by index 
        @{1}
        A=D+A
        D=M
        """.format( self.predefined_segments[seg], index )
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

    # ================================
    def asm_StorePoped2D (self) : 
        code = """
        @SP
        A=M
        D=M
        """
        return code

    def asm_StoreD2Memory( self, address ) :
        code = """
        @{0}
        M=D
        """.format( address )
        return code 

    def asm_StorePoped2Memory( self, address ) :
        code = self.asm_StorePoped2D()   
        code += self.asm_StoreD2Memory( address) 
        return code 

    def asm_StoreD2Static( self, index ) :
        code = """
        @{0}.{1}
        M=D
        """.format( self.filename , index )
        return code 
        
    def asm_StorePoped2Static( self , index  ):
        code = self.asm_StorePoped2D()   
        code += self.asm_StoreD2Static(index)
        return code


    def asm_StoreDtoSeg(self,seg,index) :
        code =  """
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
        """.format( self.predefined_segments[seg], index )
        return code  

    def asm_StorePoped2Seg( self, seg, index ) :
        code = self.asm_StorePoped2D()   
        code += self.asm_StoreDtoSeg(seg, index) 

        return code

    def asm_SP_SelfDecrease( self  ) :
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

    def asm_Goto( self , label  ) :
        code = """
        @{0}
        0 ; JMP 
        """.format( label  )

        return code 

    def asm_IfGoto( self , label ) :
        code = """
        // SP--
        @SP
        M=M-1

        // @SP
        A=M
        D=M  // push 2 D
        @{0}
        D; JNE 
        """.format( label  )

        return code 

    def asm_SaveStatus(self) :
        codes = ["    // save caller's status "]
        for PT in self.predefined_segments.itervalues():
            codes.append( self.asm_LoadMemoryContent2D( PT ) )
            codes.append( self.asm_PushDreg2Stack() ) 

        return "\n".join( codes )

    def asm_RecycleAndRestoreStatusAndRet(self, regEndFrame, regRetAddr  ) :
        segs = self.predefined_segments.values()
        segs.reverse()
        params = segs  + [ regEndFrame, regRetAddr  ]
        code = """
        // SP <- ARG+1
        @ARG
        D=M+1
        @SP
        M=D

        // endframe --
        @{4}
        M=M-1
        @{4}
        A=M
        D=M
        @{0}
        M=D
        // endframe --
        @{4}
        M=M-1
        @{4}
        A=M
        D=M
        @{1}
        M=D
        // endframe --
        @{4}
        M=M-1
        @{4}
        A=M
        D=M
        @{2}
        M=D
        // endframe --
        @{4}
        M=M-1
        @{4}
        A=M
        D=M
        @{3}
        M=D

        // goto retAddr
        @{5}
        A=M
        0 ; JMP 
        """.format( *params  ) 

        return code

    def asm_RePositionARG( self, offset ) :
        code = """
        // ARG = SP - 5 - nArgs 
        @SP
        D=M
        @{0}
        D=D-A

        @ARG
        M=D
        """.format( offset )
        return code 

    def asm_RePositionLCL( self  ):
        code = """
        // LCL = SP 
        @SP
        D=M
        @LCL
        M=D
        """
        return code 

    def asm_GotoFuncAddRetAddress(self, funcName , retAddr ) :
        code = """
        @{0}
        0 ; JMP
    ({1})
        """.format( funcName , retAddr  )
        return code 


    def asm_Memcpy1byte( dst_addr, dst_off, src_addr , src_off ):
        code = """
        """.format( dst_addr, dst_off, src_addr , src_off )

        return code 
    
    def asm_Bootstrap(self ) :
        code = """
        // SP = 256
        @256
        D=A
        @SP
        M=D
        """

        code += self.write( "call Sys.init 0" )

        return code 


    def write(self, vmcode):
        """
        translate vmcode to asm `string` 
        """

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
                if seg in self.predefined_segments:
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
                asm_codes.append( self.asm_SP_SelfDecrease() ) 
                if seg in self.predefined_segments:
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

        elif operator in ["label", "goto", "if-goto"] :
            assert len(cmds) == 2

            # TODO: is it necessary ? 
            # shouldn't compiler to ensure no LABEL conflict ? 
            LABEL_FROM_VM =  "{0}.{1}${2}".format( self.filename , self.strInFuncName if self.strInFuncName is not None else ""   ,   cmds[1]   )
            if operator == "label":
                # write label
                asm_codes.append(  "\n    ({0})\n".format( LABEL_FROM_VM  )   )
            elif operator == "goto":
                # write goto
                asm_codes.append(  self.asm_Goto( LABEL_FROM_VM  )   )
            elif operator == "if-goto" :
                # write if-goto
                asm_codes.append(  self.asm_IfGoto( LABEL_FROM_VM  )   )
            else:
                raise Exception( "wrong operator name:" + operator )
        elif operator in ["call"] :
            assert len(cmds) == 3

            funcName = cmds[1]
            nArg = cmds[2]
            
            # filename has already be included in VM code
            LABEL_RET_ADDR = "{0}$ret.{1}".format(  funcName , getUniqueID() )
            # save caller status
            asm_codes.append(  self.write(  "\tpush constant " + LABEL_RET_ADDR  ) )
            asm_codes.append(  self.asm_SaveStatus()  )

            # reposition ARG
            asm_codes.append( self.asm_RePositionARG( 5 + (int)(nArg)  ) ) 
            # reposition LCL
            asm_codes.append( self.asm_RePositionLCL() ) 
            # goto function , and insert return address
            asm_codes.append ( self.asm_GotoFuncAddRetAddress( funcName , LABEL_RET_ADDR  ) )


            pass
        elif operator in ["return"] :
            assert len(cmds) == 1
            endFrame = "R13"
            retAddr  = "R14"
            # endframe : temp[0]  <- LCL
            asm_codes.append( self.asm_LoadMemoryContent2D ( self.predefined_segments["local"] ) )
            asm_codes.append( self.asm_StoreD2Memory(  endFrame ) )
            # return address  : temp[1] , endframe - 5
            asm_codes.append( """
            @{0}
            D=M
            @5
            A=D-A
            D=M
            @{1}
            M=D
            """.format( endFrame, retAddr  ) )

            # pop return data to ARG[0]
            asm_codes.append( self.asm_SP_SelfDecrease() ) 
            asm_codes.append( self.asm_StorePoped2Seg( "argument" , 0   ) )

            # recycle  & restore
            asm_codes.append( self.asm_RecycleAndRestoreStatusAndRet( endFrame, retAddr  ) )


            pass
        elif operator in ["function"] :
            assert len(cmds) == 3

            funcName = cmds[1]
            nVars = (int)(cmds[2])

            self.strInFuncName = funcName

            # add function label 
            asm_codes.append( """
        ({0})
            """.format( funcName  ) )


            # initialize local varaible 
            if nVars > 0:
                asm_codes.append( """//       initialize local variable """ )  
                asm_codes.append( self.write( "        push constant 0" ) * nVars    )

            pass
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
    
    
    vm_file_list = []
    out_lines = []
    out_file_path = None
    
    if os.path.isdir( path ) :
        vm_file_list += [ os.path.join( path,f ) for f in os.listdir( path ) if os.path.isfile( os.path.join( path,f )  ) and f.endswith( ".vm" ) ]
        
        out_file_path = os.path.join( path , os.path.basename( os.path.normpath( path ) )  + ".asm" )
    else:
        _path , _fname = os.path.split( path )
        _fn  , _ = os.path.splitext( _fname )  

        out_file_path = os.path.join(  _path , _fn+".asm"  )
        vm_file_list.append( path )

    # start parsing
    bootStrap = None 
    for vm_path in vm_file_list : 
        asm_code , _bootstrap = parseVMFile( vm_path )
        out_lines += asm_code
        bootStrap = _bootstrap 
    
    # add bootstrap
    sys_vm = [ f for f in vm_file_list if f.endswith( "Sys.vm" ) ]
    if len( sys_vm ) > 0:
        print 'add bootstrap code ...'
        out_lines.insert( 0, bootStrap   )        

    # reinsert instruction line numbers
    out2 = []
    pc = 0
    for line in "\n".join( out_lines ).split("\n") :
        line = line.rstrip()
        line_without_comments = line.split( "//" )[0].strip()
        if not line_without_comments or line.strip().startswith("("):
            out2.append( line )
        else:
            out2.append( line + "\t\t\t// " + (str)(pc)  )
            pc += 1
        
    path_out = os.path.join( out_file_path ) 
    with open( path_out , "w") as fp:
        fp.write( "\n".join( out2 )   ) 

    print 'done'
