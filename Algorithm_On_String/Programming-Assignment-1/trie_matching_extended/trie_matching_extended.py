# python2
import sys

NA = -1


def build_trie(patterns):
    tree = dict()
    # write your code here
    tree[0] = {}
    for pattern in patterns:
        currentNode = tree[0]
        # node means a dict, stores edges 
        for currentSymbol in pattern:
            if currentSymbol in currentNode :
                node_number = currentNode[currentSymbol]
                currentNode = tree[ node_number ]
            else:
                newNode = {}
                newNode_id = len( tree )
                # add new node
                tree[ newNode_id ] = newNode 
                # add new edge 
                currentNode[currentSymbol] = newNode_id 
                currentNode = newNode 
        else:
            currentNode[ "$" ] = -1
    return tree


# only match from begining of Text 
def PrefixTrieMatching(Text ,Trie) :
    text_idx = 0
    symbol = Text[text_idx]
    v = Trie[0]
    while True:
        # if v is a leaf 
        if "$" in v :
            return True
        elif symbol in v :
            v = Trie[ v[symbol] ]
            if "$" in v :
                return True
            text_idx += 1
            symbol = Text[text_idx]
        else:
            # print "no matches found"
            return

def TrieMatching(Text, Trie):
    all_matching = []
    for i in xrange( len(Text) ):
        if PrefixTrieMatching(Text[i:] ,Trie) :
            all_matching.append( i )
    return all_matching 


class Node:
    def __init__ (self):
        self.next = [NA] * 4

def solve (text, n, patterns):
    # write your code here
    trie = build_trie( patterns )
    result = TrieMatching( text , trie  ) 

    return result


text = sys.stdin.readline ().strip ()
n = int (sys.stdin.readline ().strip ())
patterns = []
for i in range (n):
    patterns += [sys.stdin.readline ().strip ()]

ans = solve (text, n, patterns)

sys.stdout.write (' '.join (map (str, ans)) + '\n')
