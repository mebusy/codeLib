import FAdo.fa as fa 
import FAdo.reex as reex

def lexerNFA( ls_expr, ls_nfas ):
    """
    compiler: combine nfas to 1 nfa
    """

    dict_finalState_tokenIndex_mapping = {} 

    # exps = [ 'a' , 'abb' , 'a*bb*' ]
    exps = ls_expr 
    regexes = [ reex.str2regexp( e, no_table = 0  )  for e in exps ]
    nfas = [ regex.nfaPD()  for regex in regexes ]
    nfas.extend( ls_nfas  )

    nStates = [ len(nfa) for nfa in nfas ]
    iStateStart = [ 1 + sum( nStates[:i]  )   for i,nfa in enumerate(nfas) ]
    for i,nfa in enumerate(nfas):
        nfa.renameStates( xrange( iStateStart[i] , iStateStart[i] + len( nfa )  ) )
        # nfa.display()
        # print i, nfa.succintTransitions()


    N = fa.NFA()
    N.addState( '0' )
    for i,nfa in enumerate(nfas):
        for sym in nfa.Sigma:
            N.addSigma( sym )
        for state in nfa.States:
            N.addState( state )
        for state_idx in nfa.Final:
            # handle conflict
            newFinal = state_idx + iStateStart[i] 
            N.addFinal( newFinal )
            dict_finalState_tokenIndex_mapping [ newFinal ] = i 
        for stName0, syms, stName1 in nfa.succintTransitions():
            # shortcut, maybe not correct
            idx_st0 = (int)( stName0 )
            idx_st1 = (int)( stName1 )
            symbols = [ s for s in syms.split( ', ') ]
            for symb in symbols :
                N.addTransition( idx_st0 , symb , idx_st1  )
        for state_idx in nfa.Initial :
            N.addTransition( 0, '@epsilon'  , state_idx + iStateStart[i] )

    N.setInitial( [ 0 ])
    # print N
    # N.display()
    return N  , dict_finalState_tokenIndex_mapping 

def firstMatchingFinalState( N, test_states  ) :
    """
    param:
        N: NFA
        test_states : test states set
    return :
        final state index
    """
    final_states = test_states.intersection( N.Final )
    # choose the one with lower index
    ls = sorted( final_states ) 
    if len(ls) == 0:
        return -1 

    return ls[0]

