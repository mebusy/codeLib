import FAdo.fa as fa
import FAdo.reex as reex
# import FAdo.fio as fio
from lex_def import *
from NFA import lexerNFA , firstMatchingFinalState


def NFA_matching( N, word ) :
    """
    param:
        N: NFA
        word: test string 
    return stidx , len 
        stidx: the first matching final state (index)
        len: matching string length
    return -1 if no matching
    """
    lexemeBegin = 0
    forward = 0

    S = N.epsilonClosure( N.Initial ) 
    states_trace = []

    while len(S) != 0 and forward < len(word):
        sym = word[ forward ]
        # print 'eval symbol:', repr(sym)
        S =  N.evalSymbol( S , sym ) 
        if ( len(S) == 0 ):
            break
        states_trace.append( S ) 
        forward += 1

    # print states_trace 
    while len( states_trace ) > 0:
        final_state = firstMatchingFinalState( N , states_trace[-1] ) 
        if final_state > -1:
            return final_state , forward 

        states_trace.pop()
        forward -= 1

    return -1, 0 

def DFA_matching( D, N,  word ) :
    """
    param:
        D: DFA
        N: NFA
        word: test string 
    return stidx , len 
        stidx: the first matching final state (index)
        len: matching string length
    return -1 if no matching
    """
    lexemeBegin = 0
    forward = 0

    S = D.Initial
    states_trace = []

    while forward < len(word):
        sym = word[ forward ]
        S =  D.evalSymbolI( S , sym ) 
        if S == -1:
            break 
        states_trace.append( S ) 
        forward += 1

    while len( states_trace ) > 0:
        st = states_trace.pop()
        st_set =  D.States[st]
        final_state = firstMatchingFinalState( N , st_set  ) 
        if final_state > -1:
            return final_state , forward 

        forward -= 1

    # print states_trace, forward

    return -1, 0 


if __name__ == '__main__':
    N_3_26 , _ = lexerNFA( [ generateRE_ID() ], [ generateNFA_COMMENTS() ] )
    N_3_26.display()
    # print N_3_26
    # print N_3_26.evalSymbol( [1] , 'a'  )
    matching_final_state , pattern_len = NFA_matching( N_3_26 , '/*a/**/'  )
    print matching_final_state ,pattern_len

    D = N_3_26.toDFA()
    # print D.States
    matching_final_state , pattern_len = DFA_matching( D, N_3_26  , '/*\n*/*/'   )
    print matching_final_state , pattern_len


    import code
    code.interact(local=locals())
    print 'done'
