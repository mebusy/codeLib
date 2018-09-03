
import networkx as nx
import matplotlib.pyplot as plt

G = nx.Graph()

def showGraph( H ):
    plt.figure(1,figsize=(12,12)) 

    _G = H or G 
    pos = nx.shell_layout(_G)
    nx.draw(_G,pos, with_labels=True, font_weight='bold' )
    edge_labels = nx.get_edge_attributes(_G,'relation')
    nx.draw_networkx_edge_labels(_G, pos,  edge_labels)

    # plt.savefig("path.png")
    plt.show()

def test():
    e = [( "rref", "reduced form matrix", {'relation': "rref() to calc R form"}  ) ] 
    G.add_edges_from(e)
    e = [( "R", "reduced form matrix",  {'relation':  "R matrix"}  ) ] 
    G.add_edges_from(e)

    # for item in G.adjacency():
    #     print item
    showGraph()
    
def test2():
    import random
    seq = [ i for i in xrange(100) ]
    for i in xrange(1000):
        random.shuffle(seq)
        key1 = seq[0]
        key2 = seq[1]
        G.add_edges_from( [(key1, key2 , {'relation' : "{}-{}".format( key1,key2 )})] )   

    base = [ 11] 
    depth = 1
    foundset = {key for source in base for key in nx.single_source_shortest_path(G,source,cutoff=depth).keys()}
    H = G.subgraph(foundset) 

    showGraph( H )   


if __name__ == '__main__' :
    test2()
    print 'done'
