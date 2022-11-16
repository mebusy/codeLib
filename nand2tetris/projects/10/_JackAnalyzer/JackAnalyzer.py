import sys 
import os
import copy
import cgi

import FAdo.fa as fa
import FAdo.reex as reex

from NFA import lexerNFA
from NFA import firstMatchingFinalState

from lex_def import *
from LL_parser_table import RE_RULES, makeGrammarByRoughRules 
from  CFGrammarLL  import CFGrammarLL

class Tag(object):
    KEYWORD = 256
    SYMBOL = 257
    IDENTIFIER = 258
    INTEGERCONSTANT = 259
    STRINGCONSTANT = 260


nLOOKAHEAD = 2
IsJackHomeWork = True 


class Lexer(object):

    def __init__(self ):
        self._words = {} 

        self.preSetKeywords()
        self.initialize()


    def reserve(self, tag , value ):
        self._words[ value ] = { "tag" : tag  }
        
    def preSetKeywords(self) :
        keywords = [ "class", "constructor","function", "method","field", "static" , 
                     "var" ,"int", "char" , "boolean", "void", "true" , "false" , "null","this" ,
                     "let","do","if","else", "while", "return" ]
        for keyword in keywords:
            self.reserve( Tag.KEYWORD , keyword  )

    def dumpSymbolTable(self):
        print self._words 

    def initialize(self):
        self.tokens = [ generateRE_SYMBOL(),generateRE_ID(), generateRE_INT(),generateRE_STRING(),generateRE_WS() , generateRE_LINE_COMMENTS() ]
        self.nfa , self.dict_finalState_tokenIndex_mapping  = lexerNFA( self.tokens  , [ generateNFA_COMMENTS() ] )
        self.dfa = self.nfa.toDFA()
        self.pg = self.LL1_parser()


    def load( self, source_file  ):
        self._srcFilePath = source_file
        with open( source_file ) as fp:
            self._data = fp.read()
        self.lexemeBegin = 0
        self.forward = 0

    def hasCharRemains(self):
        return self.forward < len(self._data )

    def scan(self) :

        N = self.nfa
        D = self.dfa 
        
        word = self._data 
        

        S = D.Initial
        states_trace = []
        
        # print self.forward 

        while self.forward < len(word): 
            sym = word[ self.forward ]
            S =  D.evalSymbolI( S , sym ) 
            if S == -1:
                break 
            states_trace.append( S ) 
            self.forward += 1

        # print states_trace 
        while len( states_trace ) > 0:
            st = states_trace.pop()
            st_set =  D.States[st]
            final_state = firstMatchingFinalState( N , st_set  ) 
            if final_state > -1:
                val = word[ self.lexemeBegin : self.forward ] 
                self.lexemeBegin = self.forward 
                return self.dict_finalState_tokenIndex_mapping[ final_state ]  , val  
            self.forward  -= 1 


        # print states_trace, self.forward

        assert False , "no state matching"
        return -1, 0     
        # end scan

    def nextToken(self):
        while lex.hasCharRemains():
            tokenIdx , val =  lex.scan() 
            if tokenIdx < 4 :
                # generateRE_SYMBOL(),generateRE_ID(), generateRE_INT(),generateRE_STRING()
                if tokenIdx == 0 :
                    return Tag.SYMBOL , val , "symbol"
                elif tokenIdx == 1:
                    if val in self._words  :
                        return Tag.KEYWORD  , val ,  "keyword"
                    else:
                        return Tag.IDENTIFIER  , val , "identifier"
                elif tokenIdx == 2:
                    return Tag.INTEGERCONSTANT , val , "integerConstant"
                elif tokenIdx == 3:
                    return Tag.STRINGCONSTANT , val[1:-1]  , "stringConstant"
                else:
                    assert False , "wrong token index " 

        return None , None , None

    def tokenTest( self  ) :         
        _path , _fname = os.path.split( self._srcFilePath  )  
        _name , _ext = os.path.splitext( _fname  )
        dst_file = os.path.join( _path , _name + "T.xml"    )
        with open ( dst_file , "w" ) as fp:
            fp.write( "<tokens>\r\n" )
            while True:
                nextTokenIdx, val ,desc  = self.nextToken() 
                if nextTokenIdx is None:
                    break 
                else:
                    # print nextTokenIdx, val   , desc 
                    fp.write( "<{0}> {1} </{0}>\r\n".format( desc , cgi.escape( val , True )  ) )
            
            fp.write( "</tokens>\r\n" )

    def LL1_parser( self ) :
        with open( "syntax.def" ) as fp:
            gramma_text = fp.read() 
        rough_rules =  RE_RULES.findall(gramma_text)
        grammar = makeGrammarByRoughRules( rough_rules )
        pg = CFGrammarLL( grammar )

        # simple chech text formating 
        # print 'num of rules: '  ,  len(pg.rules)
        nTextRule = 0
        for line in gramma_text.split( '\n' ) :
            line = line.strip()
            if line == '' or line == ';':
                continue 
            nTextRule += 1

        # print 'num of experted rules:' , nTextRule 
        assert len(pg.rules)-1  == nTextRule , "rules number error "

        print [ t for t in pg.terminals if not t.startswith("'") ]  # and t[0].isalpha()  

        self.predictTable = pg.makePredictTable( False  )   
        return pg 


    # only used for syntax parser compare 
    def getComparableTokenValue( self,  token  ) :
        tokenID, val , desc  = token

        if tokenID in ( Tag.KEYWORD , Tag.SYMBOL ):
            return repr( val )

        if tokenID == Tag.IDENTIFIER :
            return 'identifier' 
        if tokenID == Tag.INTEGERCONSTANT :
            return 'integerConstant'
        if tokenID == Tag.STRINGCONSTANT : 
            return 'stringConstant' 
        
        return val
        
        

    def syntaxParser( self ) :
        DEBUG = False
        w = []
        while True:
            nextTokenIdx, val ,desc  = self.nextToken() 
            if nextTokenIdx is None:
                break 
            # print nextTokenIdx, val ,desc 
            w.append( ( nextTokenIdx, val ,desc  ) )

        w.append( self.pg.endmark   )
        

        M = self.predictTable 

        # init stack
        stack = [] 
        stack.append( self.pg.endmark  ) 
        stack.append( self.pg.aug_start  )
        # print stack
        ip = 0 

        xml_output = "" 

        X = stack[-1] 
        while X != self.pg.endmark :

            a = self.getComparableTokenValue( w[ip] )   
            if X == a :
                if IsJackHomeWork :
                    xml_output +=  "<{1}> {0} </{1}>".format(  cgi.escape( w[ip][1] , True )  , w[ip][2]  )
                stack.pop()
                ip += 1 
            elif X == '@epsilon' :
                stack.pop()
            elif X in self.pg.terminals :
                raise Exception(  "{} is a terminal , met token: {}".format( X , a )  )
            elif (X,a) not in M :
                raise Exception( (X,a) , " is not in predict table" )
            else :
                products = M[ (X,a) ] 
                if len( products) == 1 :
                    product = products[0]
                else:
                    if (DEBUG):
                        print 'ambigous:' , X , products
                    result = []
                    nSymbConsumes = []
                    for p in products :
                        if (DEBUG):
                            print '----- try' , p 
                        product_test = p
                        stack_test = copy.deepcopy(stack )
                        stack_test.pop()
                        stack_test.extend( reversed( product_test ) ) 
                        succuss , nSymbConsume = self.try1moreLookAhead( w , stack_test , ip  ) 
                        result.append( succuss and 1 or 0  )
                        nSymbConsumes.append( nSymbConsume  )

                    nMaxComsumed = max( nSymbConsumes ) 
                    # MaxComsumeCnt = nSymbConsumes.count( nMaxComsumed  )
                    if sum(result) == 1:
                        product =  products[ result.index(1) ]
                    elif max( nSymbConsumes) >= nLOOKAHEAD :  # MaxComsumeCnt == 1 and 
                        # pick any1 satisfied the condition 
                        product =  products[ nSymbConsumes.index( nMaxComsumed ) ]
                    else:
                        if (DEBUG):
                            print X ,'->' ,  products , result , nSymbConsumes
                        assert False , X + " need more lookahead" 

                    if (DEBUG): 
                        print 'pick product:' ,  product 
                # output 
                # print "{} -> {}".format( X , product ) 
                X_poped = stack.pop()
                if IsJackHomeWork and self.isSemantisNeed2Output( X_poped ) :
                    xml_output += "<{}>".format( X_poped) 
                    stack.append( "</{}>".format( X_poped)   )
                stack.extend( reversed( product ) )

            X = stack[-1] 
            if IsJackHomeWork :
                while True:
                    if X.startswith( "</" ) :
                        X_poped = stack.pop() 
                        xml_output += "{}".format( X_poped )
                        X = stack[-1]  
                    else:
                        break

        if IsJackHomeWork :
            self.outputXML( xml_output  )

    def isSemantisNeed2Output(self , sem ):
        if sem in ( 'type' , 'className' , 'subroutineName' , 'varName' , 'statement' ,
             'subroutineCall', 'unaryOp' , 'op' , 'keywordConstant') :
            return False 
        if sem.isupper():
            return False 
        return True 

    def try1moreLookAhead(self , w, stack , ip , level = 1):
        DEBUG = False 
        indent = '\t' + ' ' * level 
        M = self.predictTable 
        X = stack[-1] 
        ip_start = ip 
        while X != self.pg.endmark :
            a = self.getComparableTokenValue( w[ip] )   
            if X == a :
                if (DEBUG) :
                    print indent , "try-consumed : {}".format( w[ip][1] )
                stack.pop()
                ip += 1 
                if ip - ip_start  >= nLOOKAHEAD:
                    return True , ip - ip_start
            elif X == '@epsilon' :
                stack.pop()
            elif X in self.pg.terminals :
                if (DEBUG) :
                    print indent ,  "try {} is a terminal , met symobl: {}".format( X , a )
                return False  , 0
            elif (X,a) not in M :
                if (DEBUG) :
                    print indent  , (X,a) , " is not in predict table"
                return False , 0 
            else :
                products = M[ (X,a) ] 
                if len( products) == 1 :
                    product = products[0]
                else:
                    result = []
                    nSymbConsumes = []
                    for p in products :
                        if (DEBUG) :
                            print indent, '----- try' , p 
                        product_test = p
                        stack_test = copy.deepcopy(stack )
                        stack_test.pop()
                        stack_test.extend( reversed( product_test ) ) 
                        succuss , nSymbConsume = self.try1moreLookAhead( w , stack_test , ip, level+1 ) 
                        result.append( succuss and 1 or 0  )
                        nSymbConsumes.append( nSymbConsume  )

                    nMaxComsumed = ip - ip_start + max( nSymbConsumes ) 
                    # MaxComsumeCnt = nSymbConsumes.count( nMaxComsumed  )
                    if (DEBUG) :
                        print indent ,  result  ,  nSymbConsumes, nMaxComsumed 

                    if sum(result) == 1:
                        product =  products[ result.index(1) ]
                    elif nMaxComsumed >= nLOOKAHEAD:
                        # pick any1 satisfied the condition 
                        if (DEBUG) : 
                            print indent , 'picked ' 
                        return True , nMaxComsumed 
                    else:
                        # print indent, X , '->', products 
                        # assert False , indent + " try need more lookahead" 
                        return False , 0


                # output 
                if (DEBUG) :
                    print indent , "try expand {} -> {}".format( X , product ) 
                stack.pop()
                stack.extend( reversed( product ) )

            X = stack[-1] 
            if IsJackHomeWork :
                while True:
                    if X.startswith( "</" ) :
                        stack.pop()
                        X = stack[-1] 
                    else:
                        break 

        return False , 0 


    def outputXML( self, xml_str ) :
        import xml.dom.minidom
        # xml = xml.dom.minidom.parse(xml_fname) 
        xml = xml.dom.minidom.parseString(xml_str)
        pretty_xml_as_string = xml.toprettyxml( indent="  ", newl="\r\n" )
        idx = pretty_xml_as_string.find( '\n' )
        pretty_xml_as_string = pretty_xml_as_string[idx+1:] 
        
        # print pretty_xml_as_string 
        import re
        RE_PATTERN = re.compile( r'(\s*)<(\w+)/>'  )
        pretty_xml_as_string = RE_PATTERN.sub( r"\1<\2>\1</\2>" , pretty_xml_as_string   )

        _path , _fname = os.path.split( self._srcFilePath  )  
        _name , _ext = os.path.splitext( _fname  )
        dst_file = os.path.join( _path , _name + ".xml"    )
        with open ( dst_file , "w" ) as fp:
            fp.write(  pretty_xml_as_string  )


        

if __name__ == '__main__':
    if len( sys.argv ) < 2 :
        print "usage: JackAnalyzer.py  <file|directory>" 
    
    path = sys.argv[1]
    files = []

    if os.path.isdir( path ) :
        files += [ os.path.join( path,f ) for f in os.listdir( path ) 
                if os.path.isfile( os.path.join( path,f )  ) and f.endswith( ".jack" ) ]
    else:
        files += [ path ]


    lex = Lexer()
    
    for f in files :
        print 'parsing ' , f 
        lex.load( f )
        # lex.dumpSymbolTable()
        # lex.tokenTest()
        lex.syntaxParser()

    print 'done'
