
import networkx as nx

# following 2 line is for Centos7
import matplotlib
matplotlib.use('agg')
# end 

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

    #  just clear the figure instead of closing and reopening it 
    plt.gcf().clear()

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

    #TODO
    PATH = "/Volumes/WORK/WORK/mebusy_git_codeLib/myMind/staticRes"
    showGraph( H , saveto = "{}/{}".format( PATH, filename  ) )

    return filename
    

def application(env, start_response):
    # print env
    # print start_response 
    PATH_INFO = env['PATH_INFO'] 
    QUERY_STRING = env['QUERY_STRING']

    from urlparse import parse_qsl 
    parse_result = dict( parse_qsl( QUERY_STRING ) )
    # print parse_result
    if PATH_INFO == '/' :
        start_response('200 OK', [('Content-Type','text/html')])
        return [b"Hello Mind"]
    elif PATH_INFO == '/test' :
        adj = json.dumps( list(test()) )
        start_response('200 OK', [('Content-Type','text/html')])
        return [ adj ]
    elif PATH_INFO == '/searchentry' :
        # test
        # G.add_node( parse_result["key"]  )

        # if node not exist, return empty string
        start_response('200 OK', [('Content-Type','text/html')])
        if not G.has_node( parse_result["key"] ) :
            return [ "" ]

        # or return saved graph
        savedfilename = search( parse_result["key"] , depth = parse_result["depth"]  )
        return [ savedfilename ]
    elif PATH_INFO == '/clear' :
        G.clear()
        start_response('200 OK', [('Content-Type','text/html')])
        return [ "graph is clean !" ]
    elif PATH_INFO == '/addedges':
        # print env
        # the environment variable CONTENT_LENGTH may be empty or missing
        try:
            request_body_size = int(env.get('CONTENT_LENGTH', 0))
        except (ValueError):
            request_body_size = 0

        # When the method is POST the variable will be sent
        # in the HTTP request body which is passed by the WSGI server
        # in the file like wsgi.input environment variable.
        request_body = env['wsgi.input'].read(request_body_size)
        # print request_body
        edges = json.loads( request_body )
        G.add_edges_from( edges )


        start_response('200 OK', [('Content-Type','text/html')])
        return [ "success" ]
    else:
        start_response('404 Not Found', [('Content-Type','text/html')])
        return [b"Invalid URL"]



if __name__ == '__main__' :
    test2()
    print 'done'
