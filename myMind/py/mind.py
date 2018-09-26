# -*- coding: utf-8 -*-

import sys
reload(sys)
sys.setdefaultencoding('utf8')

import networkx as nx

import platform 

# following 2 line is for Centos7
if platform.system() == 'Linux' :
    import matplotlib
    matplotlib.use('agg')

import matplotlib.pyplot as plt
import json 


#TODO
STATIC_PATH = "/Volumes/WORK/WORK/mebusy_git_codeLib/myMind/staticRes"
if platform.system() == 'Linux' :
    STATIC_PATH = "/root/mindserver/staticRes"

G = nx.Graph()
subG = nx.Graph()

def showGraph( H , saveto = None ):
    plt.figure(1,figsize=(8,8)) 

    _G = H or G 
    pos = nx.shell_layout(_G)
    nx.draw(_G,pos, with_labels=True, font_weight='bold' )
    edge_labels = nx.get_edge_attributes(_G,'relation')
    nx.draw_networkx_edge_labels(_G, pos,  edge_labels, font_family="SimHei")

    if saveto :
        plt.savefig( saveto )
    else:
        plt.show()

    #  just clear the figure instead of closing and reopening it 
    plt.gcf().clear()

    
def test( key , depth ):
    testedges = r"""[["string","go",{"relation":"` `:raw\n' ' : rune"}],["string","lua",{"relation":"[[ ]]: raw & multi line"}],["string","python",{"relation":"r' ' :raw\n\"\"\" : multi line"}],["test1","test2",{"relation":"a"}],["test2","сукупність",{"relation":"我"}]]"""
    edges = json.loads( testedges )
    G.add_edges_from( edges )

    search( key , depth  , True  )

def getNameBykey(key, depth ):
    import md5 
    m = md5.new()
    m.update( key )
    m.update( str(depth) )
    return m.hexdigest() 

def spanSubGraph(  key ,  maxDepth, curDepth ):
    if curDepth > maxDepth :
        return 

    if isinstance(key, str) :
        key = key.decode("utf-8")
    print key  ,type(key)
    for k,v  in G[ key ].iteritems() :
        # print key, k, v 
        # print k,v['relation']
        subG.add_edges_from( [ ( key  , k, v ) ]   )
        spanSubGraph( k , maxDepth , curDepth + 1 )
    

def search( key , depth = 1  , bShow = False ) :
    assert isinstance( depth , int)
    key = key.lower()
    # base = [ key ]
    # foundset = {k for source in base for k in nx.single_source_shortest_path(G,source,cutoff=depth).keys()}
    # print foundset
    # H = G.subgraph(foundset) 

    subG.clear()
    spanSubGraph(  key ,  depth , 1  )
    
    filename = getNameBykey( key , depth ) + ".png"
    showGraph( subG ,  saveto = not bShow and "{}/{}".format( STATIC_PATH, filename  ) or None  )

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
    elif PATH_INFO == '/searchentry' :
        # test
        # G.add_node( parse_result["key"]  )

        # if node not exist, return empty string
        start_response('200 OK', [('Content-Type','text/html')])
        key = parse_result["key"].lower()
        if isinstance(key, str) :
            key = key.decode("utf-8")
        if not G.has_node( key ) :
            return [ "" ]

        # or return saved graph
        savedfilename = search( key , depth = int(parse_result["depth"])  )
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
        for edge in edges:
            edge[0] = edge[0].lower()
            edge[1] = edge[1].lower()
        G.add_edges_from( edges )


        start_response('200 OK', [('Content-Type','text/html')])
        return [ "success" ]
    else:
        start_response('404 Not Found', [('Content-Type','text/html')])
        return [b"Invalid URL"]



if __name__ == '__main__' :
    import sys
    args = sys.argv
    # print args
    key = "сукупність"
    depth = 2
    if len( args) > 1:
        key = args[1]
    if len( args ) > 2:
        depth = int(args[2])
    print key, depth
    test( key , depth  )
    print 'done'
