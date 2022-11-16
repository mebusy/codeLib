import re
import sys
import os

RE_LABEL_DEFINE = re.compile( r"\(\s*(.+?)\s*\)" )
RE_C_INSTRUCTION = re.compile( r"(?:\s*(\w+)\s*=)?\s*([^;]+)\s*(?:;\s*(\w+)\s*)?" )


comp_mapping = """
0     101010
1     111111 
-1     111010 
D     001100
A     110000
!D     001101
!A     110001
-D     001111
-A     110011
D+1     011111
A+1     110111
D-1     001110
A-1     110010
D+A     000010
D-A     010011
A-D     000111
D&A     000000
D|A     010101
"""

dest_jump_mapping = """
null 000 null 000 
M 001 JGT 001 
D 010 JEQ 010 
MD 011 JGE 011 
A 100 JLT 100 
AM 101 JNE 101 
AD 110 JLE 110 
AMD 111 JMP 111
"""


def init_symbol_table() :
    tbl = {}

    for i in xrange(16) :
        tbl[ "R" + str(i) ] = i 
    tbl["SCREEN"] = 1024 * 16
    tbl["KBD"] = tbl["SCREEN"] + 1024*8

    tbl["SP"] = 0 
    tbl["LCL"] = 1 
    tbl["ARG"] = 2 
    tbl["THIS"] = 3 
    tbl["THAT"] = 4 

    return tbl


free_vari_address = 16 
def getVariableAddr( var_name ) :
    global free_vari_address 

    if var_name not in symbol_tabel:
        symbol_tabel[ var_name ] = free_vari_address
        free_vari_address += 1
    
    return symbol_tabel[ var_name ] 

def label_parser( path ) :
    with open( path ) as fp:
        lines = fp.readlines()
        
    codes = [] 
    pc = 0 
    for line in lines:
        items = line.split("//") 
        code = items[0].strip()
        # print code

        if code == "" :
            continue
        
        # check label
        label_ret = RE_LABEL_DEFINE.search( code ) 
        if label_ret is not None:
            label = label_ret.group(1) .strip()

            assert label not in symbol_tabel 
            symbol_tabel[ label ] = pc
        else:
            codes.append( code )
            pc += 1 

    return codes 

def convert(codes) :
    for i,code in enumerate(codes):
        # print i,code

        if code.startswith("@"): 
            generateA( code[1:]  ) 
        else :
            generateC( code.replace( " ", "" ).replace("\t", "" )   )

def generateA( value ) :
    global mc_out
    if value.isdigit():
        mc_out += "{0:016b}\n".format( int(value) ) 
    else:
        mc_out += "{0:016b}\n".format( getVariableAddr( value  ) ) 


def generateCompInst( comp , a ) :
    if a == 1:
        comp = comp.replace( "M", "A" )

    result =  comp_table[ comp ]
    return str(a) + result 


def generateC( code ) :
    # no whitespace
    c_result = RE_C_INSTRUCTION.search( code ) 
    assert c_result is not None 

    # print code ,c_result.groups()
    dest, comp, jmp = c_result.groups()
    assert comp is not None 

    inst = "111"  # c head
    a = 0
    if comp.find( "M" ) != -1:
        a = 1 
    
    inst += generateCompInst( comp, a  )

    inst += dest_table[ dest or "null" ] 
    inst += jump_table[ jmp or "null" ]
    
    global mc_out    
    mc_out += inst + "\n"


if __name__ == '__main__' :
    if len(sys.argv) < 2:
        print 'usage: ./Assembler.py asm_path'
        sys.exit(0)
    
    mc_out = "" 

    path = sys.argv[1]
    print 'converting ' , path
    symbol_tabel = init_symbol_table()

    comp_table = {}
    items =  re.findall( r"\S+" , comp_mapping )
    for i in xrange( len(items)/2 ) :
        comp_table[ items[i*2]] = items[i*2+1]      
    # print comp_table
    dest_table = {}
    jump_table = {}
    items =  re.findall( r"\S+" , dest_jump_mapping )
    for i in xrange( len(items)/4):
        dest_table[ items[i*4]] = items[i*4+1]      
        jump_table[ items[i*4+2]] = items[i*4+3]      
    # print dest_table , jump_table



    codes = label_parser(path) 
    # for i,v in enumerate( codes ) :
    #     print i,v 

    convert( codes )
    # print mc_out 

    _path , _ext = os.path.splitext( path )
    with open(  _path + ".hack" , "w"  ) as fp:
        fp.write( mc_out )

