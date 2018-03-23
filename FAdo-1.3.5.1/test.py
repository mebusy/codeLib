
import FAdo.fa as fa
import FAdo.reex as reex
from lex_def import generateRE_WS  
reg = reex.str2regexp( "(a*)?b"  , no_table = 0 )

print repr(reg)

nfa = reg.nfaPD()
# nfa.display()
for stName0, syms, stName1 in nfa.succintTransitions():
    print syms
    for i in syms.split(', '):
        print '\t', repr(i)

S = nfa.Initial 
print nfa.evalSymbol( S , 'a' ) 

dfa = nfa.toDFA()
dfa.display()

dfa.evalSymbolI( dfa.Initial , 'a'   )
