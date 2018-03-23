from collections import defaultdict


class CFGrammarLL( object) :
    def __init__(self, grammar ):
        self.endmark = '$'
        self.rules = []
        self.nonterminals = set( {} )
        self.all_symbols = set( {} ) 
        self.terminals = set( {} )
        self.nt_rules = defaultdict( list ) # which can  find all rules by non-terminal key 

        self.start = grammar[0][0]
        self.aug_start = "@S"
        # self.nonterminals.add(self.aug_start)
        grammar.append( (self.aug_start, [self.start], None ) )

        for lhs , product , _ in grammar :
            product = tuple(product)
            self.rules.append( ( lhs, product  )  )
            self.nonterminals.add( lhs )
            self.all_symbols.update( product )
            self.nt_rules[lhs].append( product ) 

        self.terminals = self.all_symbols - self.nonterminals | { self.endmark }

        # print 'start: ' , self.start
        # print "nt:" , self.nonterminals 
        # print ' t:' , self.terminals 

        self.makeFirst()
        self.makeFollow()

        pass

    def makeFirst( self ) :
        self.first = defaultdict( set ) 
        # 1
        for X in self.terminals:
            self.first[X].add( X ) 
        # 3
        for X in self.nonterminals:
            for product in self.nt_rules[X]:
                if len( product ) == 1 and product[0] == '@epsilon' :
                    self.first[X].add( '@epsilon' )
                    continue 

        # 2
        nCnt = -1  # 
        while True: 
            nCntNew = 0    
            for X in self.nonterminals:
                for product in self.nt_rules[X]:
                    if len( product ) == 1 and product[0] == '@epsilon' :
                        continue 
                    # non e product
                    for i, Y in enumerate( product ):
                        # always add FIRST(Y1)
                        first_y = self.first[Y]
                        self.first[X].update( first_y )
                        if '@epsilon' not in first_y :
                            break 
                    else:
                        self.first[X].add( '@epsilon' )  

            for k,v in self.first.iteritems():
                nCntNew += len(v)
            
            if nCntNew == nCnt :
                break
            nCnt = nCntNew 
                    
        # for k,v in self.first.iteritems():
        #     print k,v

    def FIRST( self, alpha  ) :
        first = set( {} )
        e_set = {'@epsilon'} 
        for i,Xi in enumerate(alpha) :
            firstXi = self.first[Xi]
            first |= (  firstXi - e_set  )
            if '@epsilon' not in firstXi:
                break 
        else:
            first.add( '@epsilon' )  

        return first  
             
    # to generate FOLLOW according to <<compiler>>
    def makeFollow(self):
        e_set = {'@epsilon'} 
        self.follow = defaultdict(set)  
        self.follow[self.start ] |= { self.endmark }
        for lhs , product  in self.rules:
            r = product
            for i , nt in enumerate( r ) :
                if nt in self.nonterminals :
                    j = i+1
                    self.follow[ nt ] |= ( self.FIRST( r[j:] ) - e_set  )

        nCnt = -1 
        # for _ in xrange( 2 ) :
        while True:
            nCntNew = 0 
            for lhs, r  in self.rules:
                for i , nt in enumerate( r ) :
                    if nt in self.nonterminals :
                        j = i+1
                        if '@epsilon' in self.FIRST( r[j:] ) or i == len( r ) - 1 :
                            self.follow[ nt ] |= ( self.follow[ lhs ] - e_set )
                        
                    
            for k,v in self.follow.iteritems():
                nCntNew += len(v)
            
            if nCntNew == nCnt :
                break
            nCnt = nCntNew 
        # for k,v in self.follow.iteritems():
        #     print k,v 

    def makePredictTable( self , debug=False ) :
        terminals , nonterminals ,    follow =  self.terminals , self.nonterminals  ,   self.follow
        # check shadow rules
        # M = defaultdict( list )
        # for lhs , product , action in self.rules:
        #     M[lhs].append( product ) 
        #
        # for lhs, products  in M.iteritems() :
        #     if lhs != '@S' and len( products ) == 1 and len(products[0]) == 1:
        #         print 'single product single item rule: '  , lhs, products[0][0] 

        M = defaultdict( list )

        for lhs , product in self.rules:
            A = lhs
            alpha = product
            tup_alpha = tuple( product  )

            # print first_a
            for terminal_a in self.FIRST( alpha ) : 
                key = ( A, terminal_a ) 
                if tup_alpha not in M[key]:
                    # if A == 'OP_TERM_STAR' and terminal_a == "'-'"  :
                    #     print lhs, product , terminal_a  , alpha, self.FIRST( alpha )
                    M[key].append( tup_alpha ) 

            if "@epsilon" in self.FIRST( alpha  ) :
                # epsilon is in FIRST(alpha)
                follow_terminals = follow[ A ]
                for b in follow_terminals  :
                    # check
                    if b == "@epsilon" :
                        raise Exception( "@epsilon can not be in follows " )
                    key = ( A, b) 
                    if tup_alpha not in M[key]:
                        # if A == 'OP_TERM_STAR' and b == "'-'" :
                        #     print lhs, product 
                        #     print self.FIRST( alpha  )  , self.FIRST([A])
                        #     print follow[ A ]   
                        M[key].append( tup_alpha ) 

                # if '$' in follow_terminals :
                #     key = ( A, '$' ) 
                #     if tup_alpha not in M[key]:
                #         M[key].append( tup_alpha ) 

        for key , v  in M.iteritems() :
            if len(v) > 1:
                print '!!! amibigours grammar in :{} '.format(key) 
                print '\t,which has many possible products {}'.format(  v ) 

        # print terminals 
        # print nonterminals
        if debug:
            ls_t = [ i for i in terminals if i not in [ "@epsilon" , '#' ] ]
            ls_nt = [ i for i in nonterminals  ]
            
            out = ''
            for t in [ ' ' ] +  ls_t  :
                out += "{0:15}".format( t  )
            print out
            print '-' * ( -7 + 15 * ( len( ls_t ) + 1) )

            for nt in ls_nt :
                out = ''
                out += "{0:15}".format( nt  )
                for t in ls_t :
                    prod = " / " 
                    if len( M[(nt,t)]  ) > 0 :
                        prod = " ".join( M[(nt,t)][0]  )
                    out += "{0:15}".format(  prod  + ( "" if len( M[(nt,t)]  ) < 2 else " ~")  )
                print out
        
        return M 
