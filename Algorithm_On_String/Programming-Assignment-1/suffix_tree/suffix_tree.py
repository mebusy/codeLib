# python2
import sys
from collections import Counter
import pprint

word_count = None
word_firstOccur = {} 
subStrings = {}

def createNewNode( tree , bTerminal = False  ) :
    # create new node for suffix string 
    newNode = {}
    newNode_id = len( tree ) 
    if bTerminal:
        newNode_id = -newNode_id
    # add new node
    tree[ newNode_id ] = newNode 
    return newNode_id 

# return terminal node id 
# otherwise  , return None
def addToNode( parentNode,  startPosInText , LenOfSuffixEdge , OriginText , tree  ):
    
    while True:
        key = ( startPosInText , LenOfSuffixEdge  )
        # case 1: starting with un-dup char
        # case 2: it is a sub string 
        if word_count[ OriginText[startPosInText] ] == 1 \
                or key in subStrings :
            
            newNode_id = createNewNode(tree, True )
            parentNode[ key  ] = newNode_id 
            
            if parentNode == tree[0]:
                subStrings[ key] = newNode_id 

            return newNode_id
        else:
            index = word_firstOccur[ OriginText[startPosInText] ]
            key = ( index , 1 )

            if key in subStrings:
                if key in parentNode :
                    pass
                else:
                    newNode_id = createNewNode(tree) 
                    parentNode[ key  ] = newNode_id 
            else:
                newNode_id = createNewNode(tree) 
                parentNode[ key  ] = newNode_id 
            
                if parentNode == tree[0]:
                    subStrings[ key] = newNode_id 
        parentNode,  startPosInText , LenOfSuffixEdge = tree[ parentNode[ key  ]  ] , startPosInText + 1 , LenOfSuffixEdge - 1 
        # return addToNode( tree[ parentNode[ key  ]  ] , startPosInText + 1 , LenOfSuffixEdge - 1 , OriginText , tree   )

        pass 


# e.g. {0:{(0,8):1,(2,3):2},1:{(4,2):3}}
def build_suffix_tree(text):
    """
    Build a suffix tree of the string text and return a list
    with all of the labels of its edges (the corresponding 
    substrings of the text) in any order.
    """
    # Implement this function yourself
    tree = {}
    tree[0] = {}


    nLenText = len(text)
    for startPosInText in xrange(nLenText):
        
        currentNode = tree[0]
        
        startPos = nLenText - 1 - startPosInText
        nLen = nLenText - startPos 
        terminal_node_id = addToNode( currentNode , startPos ,  nLen  , text , tree )
        if terminal_node_id :
            tree[terminal_node_id] = startPos

    
    # find all single child edge
    single_child_edges = {}
    for key , d in tree.items():
        if key >= 0 and len(d) == 1:
            single_child_edges[ key ] = d
            del tree[key]

    # merge single child edge
    for key, d in tree.iteritems():
        if key < 0 : 
            continue
        for k , v in d.items():
            while v in single_child_edges:
                k2,v2 = single_child_edges[v].iteritems().next()
                s,l = k
                s2,l2 = k2 
                del d[k]    
                k = ( s,l+l2  )
                v = v2 
                # v is terminal node
                if v in tree and v < 0 :
                    k = ( nLenText-(l+l2)  , l+l2 )
                d[k] = v 


    # pp = pprint.PrettyPrinter(width=20)
    # pp.pprint( tree )

    result = []
    for k,d  in tree.iteritems():
        if k < 0 : 
            continue
        for edge , v in d.iteritems():
            s,l = edge
            result.append( text[ s:s+l  ] )
    return result



if __name__ == '__main__':
    text = sys.stdin.readline().strip()
    # text = "CCAAGCTGCTAGAGG" + "#"  + "CATGCTGGGCTGGCT" + "$"
    word_count = Counter(text) 
    for key in word_count.iterkeys():
        word_firstOccur[key] = text.index( key )

    result = build_suffix_tree(text)
    print("\n".join(result))
    

 
