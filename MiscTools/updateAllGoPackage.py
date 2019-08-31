import subprocess
import sys
import os

def runBashCmd( cmd ):
    child = subprocess.Popen( cmd , stdout=subprocess.PIPE , stdin=subprocess.PIPE, stderr=subprocess.STDOUT , shell=True )
    streamdata = child.communicate()[0]
    rc = child.returncode
    if rc != 0:
        print cmd , "exit with" , rc  
        sys.exit( 1 )

    return streamdata 


def updateAll():
    gopaths = os.environ['GOPATH'].split( ":" )  
    gopath = gopaths[0]
    print "GOPATH:" , gopath

    updated = {} 
    excludes = [
        "github.com/go-gl/glfw" , 
    ]

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
        
        if True or paths[0] == "golang.org" or package in excludes  :
            runBashCmd( "cd " + path_package  )
            runBashCmd( "git checkout master && git pull" ) 
            print "update repo " + package
        else:
            cmd = "go get -u " + package
            print cmd 
            print runBashCmd( cmd  )


    # final
    cmds = [ 
        "go get golang.org/x/mobile/cmd/gomobile" , 
        "gomobile init"  , 
        "go get github.com/codegangsta/gin" , 
        "go get github.com/gopherjs/gopherjs" , 
        "go get github.com/hajimehoshi/ebiten/..." , 
    ]
    for cmd in cmds:
        print cmd
        print runBashCmd(cmd) 


if __name__ == '__main__':
    print "start updating all go pacakge" 

    updateAll()

    print "done"
