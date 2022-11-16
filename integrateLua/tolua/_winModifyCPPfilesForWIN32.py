
import os 
import sys
import shutil

if __name__ == '__main__':
    if len(sys.argv) < 2 :
        print 'no cpp file need to modify'
        sys.exit(0)

    folders = sys.argv[1:]
    # print folders 

    CPP_WIN_DIR = "X:/project_rabbits_test/art/project_rabbits_main/Main/Source/Twelve/Game/Lua"     

    for folder in folders:
        files = [ f  for f in os.listdir( folder ) if os.path.isfile( os.path.join( folder , f )  ) and f.endswith(".cpp") ]
        # print files
        for f in files:
            SRC_FILE = os.path.join( folder , f ) 
            DST_FILE = os.path.join( CPP_WIN_DIR , f )

            with open( SRC_FILE ) as fp :
                data = fp.read() 
                if folder.startswith( "src_misc/win" ) :
                    data = data.replace( "../FileUtils.h" , "FileUtils.h" )

            with open( DST_FILE , "w" ) as fp:
                # engine specification
                output =  "#if defined(ONYX_PLATFORM_WIN32) || defined(ONYX_PLATFORM_WIN64) \n"  
                output += data 
                output += os.linesep 
                output += "#endif" 

                lines = output.split( "\r")

                for i,line in enumerate(lines):
                    lines[i] = line.rstrip() + "\n"
                

                fp.write( "".join (lines) ) 

    print 'make cpp file for win32 down !'
