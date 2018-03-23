import string
import FAdo.fa as fa  

ID_HEADER = "{}_".format( string.letters )
ID_FOLLOWS = "{0}{1}".format( ID_HEADER ,  string.digits  )

def generateRE_SYMBOL():
    symbols =  '{}()[].,;+-*/&|<>=~'

    allchars = symbols
    ls_special = [ '?', ':' ,  '&' , '~' ,  '|' ,    '*' , '(' , ')' , '@'  ]
    for speical in ls_special:
        allchars = allchars.replace(  speical , "" ) 

    chars = [i for i in allchars ]
    for special in ls_special:
        chars.append( "@{}".format( special  )  ) 
    
    group_symbol = "|".join( chars )
    return "{}".format(group_symbol)

def generateRE_INT():
    chars = [i for i in string.digits   ]
    chars.remove( '0' )
    group_header = "|".join( chars )

    chars = [i for i in string.digits   ]
    group_follows = "|".join( chars )

    return "0|(({})({})*)" .format( group_header, group_follows  )  # for Jack language with no oct number
    # return  "({})({})*" .format( group_follows, group_follows  )

def generateRE_STRING():
    allchars = string.digits + string.letters + string.punctuation + ' '
    ls_special = [ '?', ':' ,  '&' , '~' ,  '|' ,    '*' , '(' , ')' , '@' ]
    for speical in ls_special:
        allchars = allchars.replace(  speical , "" ) 

    # directly single use  to ",  and  \ right before end quite "  is not allowed , 
    # only \\" \\  combination is allowed
    allchars = allchars.replace(  '"' ,  '' ) 
    allchars = allchars.replace(  '\\' ,  '' ) 

    # print "all printable:" , allchars
    # allchars = string.letters
    
    chars = [i for i in allchars ]
    for special in ls_special:
        chars.append( "@{}".format( special  )  ) 

    # for '\t' in source file
    chars.append( "@t" )

    group_single_char = "|".join( chars )

    chars.append( '\\' )
    chars.append( '"' )
    group_escaple_follows =  "|".join( chars ) 
    
    # print group_single_char

    return '"({0}|(@\\({1})))*"'.format( group_single_char , group_escaple_follows   ) 
    

def generateRE_ID() :
    chars = [i for i in ID_HEADER  ]
    group_header = "|".join( chars )

    chars = [i for i in ID_FOLLOWS  ]
    group_follows = "|".join( chars )

    return "({0})({1})*".format( group_header , group_follows  )

def generateRE_WS():
    chars = [ ' ' , '@t' , '@r' , '@n'   ]
    group_ws = "|".join( chars )
    return "({0})({0})*" .format( group_ws  )

def generateRE_LINE_COMMENTS():
    allchars = string.digits + string.letters + string.punctuation + ' '
    ls_special = [ '?', ':' ,  '&' , '~' ,  '|' ,    '*' , '(' , ')' , '@' ]
    for speical in ls_special:
        allchars = allchars.replace(  speical , "" ) 

    chars = [i for i in allchars ]
    for special in ls_special:
        chars.append( "@{}".format( special  )  ) 

    # for '\t' in source file
    chars.append( "@t" )
    # chars.append( "@r" )

    group_any_char = "|".join( chars )

    # print group_single_char

    # not include \r \n
    return '//({})*'.format(group_any_char) 
    
def generateNFA_COMMENTS():
    allchars = string.printable 
    chars = [i for i in allchars ]

    N = fa.NFA()
    N.addState( '0' )
    N.addState( '1' )
    N.addState( '2' )
    N.addState( '3' )
    N.addState( '4' )

    finalState = (int)(N.States[-1])

    N.setSigma( chars )

    # transition
    N.addTransition( 0, '/' , 1  )
    N.addTransition( 1, '*' , 2  )

    for sigm in N.Sigma:
        if sigm == '*' :
            N.addTransition( 2, sigm , 3  )
        else:
            N.addTransition( 2, sigm , 2  )


    for sigm in N.Sigma:
        if sigm == '*' :
            N.addTransition( finalState-1, sigm , finalState-1  )
        elif sigm == '/':
            N.addTransition( finalState-1, sigm , finalState  )
        else:
            N.addTransition( finalState-1, sigm , 2  )

    N.setInitial( [ 0 ])
    N.addFinal( finalState  )
    # N.display()
    # print N 
    
    return N 


if __name__ == '__main__':
    import FAdo.fa as fa
    import FAdo.reex as reex

    def test( str_re ) :
        print str_re
        reg = reex.str2regexp( str_re , no_table = 0 ) 
        print reg 

        nfa = reg.nfaPD()
        nfa.display()
        
    
    RE_SYMBOL = generateRE_SYMBOL()
    RE_INT = generateRE_INT()
    RE_STR = generateRE_STRING()
    RE_ID = generateRE_ID()
    RE_WS = generateRE_WS() 
    RE_COMMENTS = generateRE_LINE_COMMENTS()  
    # test(  RE_COMMENTS  )
    generateNFA_COMMENTS()
    

    print 'done'
