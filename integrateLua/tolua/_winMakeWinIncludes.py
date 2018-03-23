
import os
import shutil 
import sys

if __name__  == '__main__' :
    print sys.platform 
    INCLUDE_WIN_DIR = "include_win" 
    if os.path.exists( INCLUDE_WIN_DIR ) :
        shutil.rmtree( INCLUDE_WIN_DIR )
    os.makedirs ( INCLUDE_WIN_DIR )
    
    files = os.listdir( 'include' )
    for f in files: 
        fpath = os.path.join( 'include' , f )
        info = os.stat(fpath)
        # print info
        # isLink = os.path.islink( fpath ) 
        # print isLink

        source_file = fpath 
        isLink = not os.path.islink( fpath )  and info.st_size < 128 
            
        if isLink :
            print fpath  , "is a linkfile "
            with open(fpath) as fp :
                source_file = os.path.join( "include" ,  fp.read().strip() )
        # print source_file        

        shutil.copyfile( source_file , os.path.join( INCLUDE_WIN_DIR , f  ) )

    f = "luabinding.h" 
    fpath = os.path.join(  "../luabinding/luabinding/" , f ) 
    shutil.copyfile( fpath , os.path.join( INCLUDE_WIN_DIR , f  ) )
        

    print 'done'
