
import os 
import sys
import re
import difflib


def modifyLua( IP , DB_IP  ):
    RE_IP = re.compile( r'(mysql_host|uwsgi_host)\s*=\s*"([^"]+?)"' )

     
    path = 'lua/_db.config' 
    with open( path , "r" ) as f:
        data = f.read()
        print '\t',  RE_IP.findall( data ) , 'will be replaced to ' , DB_IP         

    mdata =  RE_IP.sub( r'\1="{}"'.format( DB_IP ) , data  ) 
    for line in difflib.context_diff(data.split(), mdata.split(), fromfile='before.py', tofile='after.py'):
        if line.startswith('!'):
            print '\t - ',line
    with open( path , "w" ) as f:
        f.write(mdata)



    pass

def modifyJS( IP):
    JS_DIR = 'webTools/eventTool/static/js'
    files =  os.listdir( JS_DIR ) 
    files = [ os.path.join( JS_DIR , f ) for f in files ]
    
    for path in files:
        bJS =  path.endswith( ".js" )
        if bJS:
            RE_IP = re.compile( r'(var\s+\w+\s*=\s*")(\w+(?:\.\w+)+)(")' ) 
            with open( path , "r+" ) as f:
                data = f.read()
                res =  RE_IP.findall( data )
                assert len( res ) > 0
                print '\t',  res , 'will be replaced to ' , IP         

           
            mdata = data.replace( res[0][1] ,  IP  )  
            for line in difflib.context_diff(data.split(','), mdata.split(','), fromfile='before.py', tofile='after.py'):
                if line.startswith( '!' ):
                    print '\t - ',line
            with open( path , "w" ) as f:
                f.write( mdata )
    pass


if __name__ == '__main__':
    if len(sys.argv) < 3:
        print 'usage: python setupServer.py <external server ip or domain> <db server ip or domain> '
        sys.exit(1)

    _IP = sys.argv[1]
    print 'will use' , _IP, 'as external game server IP/domain'
    _DB_IP = sys.argv[2]
    print 'will use' , _DB_IP, 'as DB IP/domain'

    modifyLua(_IP, _DB_IP)
    modifyJS( _IP)



    print 'setup server done'

