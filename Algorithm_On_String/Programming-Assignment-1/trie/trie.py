#Uses python2
import sys

# Return the trie built from patterns
# in the form of a dictionary of dictionaries,
# e.g. {0:{'A':1,'T':2},1:{'C':3}}
# where the key of the external dictionary is
# the node ID (integer), and the internal dictionary
# contains all the trie edges outgoing from the corresponding
# node, and the keys are the letters on those edges, and the
# values are the node IDs to which these edges lead.
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

    return tree


if __name__ == '__main__':
    patterns = sys.stdin.read().split()[1:]
    tree = build_trie(patterns)
    for node in tree:
        for c in tree[node]:
            print("{}->{}:{}".format(node, tree[node][c], c))
