import subprocess


if __name__ == '__main__' :
    cmd = "ls *.o"
    res = subprocess.Popen( cmd , stdout=subprocess.PIPE , stdin=subprocess.PIPE, stderr=subprocess.STDOUT , shell=True ).stdout.read()
    items = res.split()

    print " ".join( items )
