from FAdo.yappy_parser import  grules 
import re 
from collections import defaultdict 


gramma_text = """
E  -> T E_
    ;
 E_ -> + T E_ 
    | @epsilon
    ;

T  -> F T_
    ;
    
T_ -> * F T_ 
    | @epsilon
    ;
    
F  -> ( E ) 
    | id
    ; 
"""

gramma_text_2 = """
 S -> i E t S S_ 
    | a 
    ;
S_ -> e S 
    | @epsilon
    ;
E -> b
    ; 

"""




def DefaultSemRule(list,context=None):
    """Default semantic rule"""
    return list[0]


grammar2 = grules( [ ( 'reg -> ;' ,DefaultSemRule  )  ] )


RE_RULES = re.compile( r"""\s*(\w+)\s*->(.*?)  # leftside start
                           ((?:\s*\n\s*\|.*?)*)   # more products 
                           \n\s*;   # end mark 
                        """, re.X  ) 
RE_MORE_RULES = re.compile(  r'\s*\n\s*\|(.*)'  )
RE_PRODUCTION_SEP = re.compile( r'[^"\']\|[^"\']' )

def makeGrammarByRoughRules( rules ) :
    yap_rules = []

    for lhs , fst_product , other_products in rules :
        more_products = RE_MORE_RULES.findall( other_products  )
        # print lhs, fst_product , more_products
        products = [ fst_product ]
        products.extend( more_products  ) 
        # print products 
        for p in products :
            # check grammer text format
            if RE_PRODUCTION_SEP.search( p ) is not None:
                err =  "| in production {}->{} is not allowed !!".format( lhs, p )  
                raise Exception( err )
            # if action is provide, the element will be a turple 
            yap_rules.append(  ("{} -> {}".format( lhs , p )   ) )
        

    
    return grules( yap_rules  )





if __name__ == '__main__':
    from CFGrammarLL import CFGrammarLL 
    # import sys
    rough_rules =  RE_RULES.findall(gramma_text)
    # rough_rules =  RE_RULES.findall(gramma_text_2)
    # print rough_rules 
    grammar = makeGrammarByRoughRules( rough_rules )
    pg = CFGrammarLL( grammar )
    pg.makePredictTable( True  ) 
    
    # import code
    # code.interact(local=locals())

    print 'done'
