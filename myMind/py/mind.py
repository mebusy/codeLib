
import networkx as nx
import matplotlib.pyplot as plt

G = nx.Graph()

def showGraph():
    pos = nx.spring_layout(G)
    nx.draw(G,pos, with_labels=True, font_weight='bold' )
    edge_labels = nx.get_edge_attributes(G,'relation')
    nx.draw_networkx_edge_labels(G, pos,  edge_labels)

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
    

if __name__ == '__main__' :
    test()
    print 'done'
