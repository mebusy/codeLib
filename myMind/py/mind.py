
import networkx as nx
import matplotlib.pyplot as plt
import json 

G = nx.Graph()

def showGraph( H , saveto = None ):
    plt.figure(1,figsize=(12,12)) 

    _G = H or G 
    pos = nx.shell_layout(_G)
    nx.draw(_G,pos, with_labels=True, font_weight='bold' )
    edge_labels = nx.get_edge_attributes(_G,'relation')
    nx.draw_networkx_edge_labels(_G, pos,  edge_labels)

    if saveto :
        plt.savefig( saveto )
    else:
        plt.show()

def test():
    e = [( "rref", "reduced form matrix", {'relation': "rref() to calc R form"}  ) ] 
    G.add_edges_from(e)
    e = [( "R", "reduced form matrix",  {'relation':  "R matrix"}  ) ] 
    G.add_edges_from(e)

    return G.adjacency() 
    # for item in G.adjacency():
    #     print item
    # showGraph()
    
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

def getNameBykey(key):
    import md5 
    m = md5.new()
    m.update( key )
    return m.hexdigest() 

def search( key , depth = 1  ) :
    base = [ key ]
    foundset = {key for source in base for key in nx.single_source_shortest_path(G,source,cutoff=depth).keys()}
    H = G.subgraph(foundset) 
    
    filename = getNameBykey( key ) + ".png"
    showGraph( H , saveto = "/Volumes/WORK/WORK/mebusy_git_codeLib/myMind/staticRes/{}".format( filename  ) )

    return filename
    

def application(env, start_response):
    # print env
    # print start_response 
    PATH_INFO = env['PATH_INFO'] 
    QUERY_STRING = env['QUERY_STRING']
    if PATH_INFO == '/' :
        start_response('200 OK', [('Content-Type','text/html')])
        return [b"Hello Mind"]
    elif PATH_INFO == '/test' :
        adj = json.dumps( list(test()) )
        start_response('200 OK', [('Content-Type','text/html')])
        return [ adj ]
    elif PATH_INFO == '/searchentry' :
        savedfilename = "hahaha" # search( 'a', depth = 1 )
        start_response('200 OK', [('Content-Type','text/html')])
        return [ savedfilename ]
    else:
        start_response('404 Not Found', [('Content-Type','text/html')])
        return [b"Invalid URL"]



if __name__ == '__main__' :
    test2()
    print 'done'
