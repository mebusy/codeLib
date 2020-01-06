import subprocess
import sys
import os

def runBashCmd( cmd  ):
    child = subprocess.Popen( cmd , stdout=subprocess.PIPE , stdin=subprocess.PIPE, stderr=subprocess.STDOUT , shell=True )
    streamdata = child.communicate()[0]
    rc = child.returncode
    if rc != 0:
        print cmd , "exit with" , rc  , streamdata
        if streamdata.find("no Go files in")==-1 and streamdata.find( "found meta tag get.metaImport{Prefix:" ) == -1 :
            # sys.exit( 1 )
            pass  # no longer exit

    return streamdata 


def updateAll():
    gopaths = os.environ['GOPATH'].split( ":" )  
    gopath = gopaths[0]
    print "GOPATH:" , gopath

    for repo in [ "github.com/0xAX/notificator"  ]:
        print runBashCmd( "rm -rf {}/src/{}".format( gopath , repo) )

    updated = {} 

    cmd = "go list ..."
    res =  runBashCmd( cmd )
    packages = res.split( "\n" )
    for _package in packages:
        paths = _package.split( "/" )
        if len(paths) < 3 :
            continue  

        package = "/".join( paths[:3])

        if package in updated:
            continue 

        path_package = os.path.join( gopath, "src", package  )
        if not os.path.isdir(path_package):
            continue 

        updated[ package ] = 1
        
        if paths[0] == "golang.org" :
            # repo update only
            runBashCmd( "cd " + path_package  )
            runBashCmd( "git checkout master && git pull" ) 
            print "update repo " + package
        else:
            cmd = "go get -v -u " + package
            print cmd 
            print runBashCmd( cmd  )


    # final
    cmds = [ 
        "go get -v golang.org/x/mobile/cmd/gomobile" , 
        "gomobile init"  , 
        "go get -v -u github.com/codegangsta/gin" , 
        "go get -v -u github.com/gopherjs/gopherjs" , 
        "go get -v -u github.com/hajimehoshi/ebiten/..." , 
    ]
    for cmd in cmds:
        print cmd
        print runBashCmd(cmd ) 


if __name__ == '__main__':
    print "start updating all go pacakge" 

    updateAll()

    print "done"
